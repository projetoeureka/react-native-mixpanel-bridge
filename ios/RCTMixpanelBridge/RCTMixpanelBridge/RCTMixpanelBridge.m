//
//  RCTMixpanelBridge.m
//  RCTMixpanelBridge
//
//  Created by Lucas on 06/02/17.
//  Copyright © 2017 Geekie. All rights reserved.
//

#import "RCTMixpanelBridge.h"
#import "Mixpanel.h"

@interface Mixpanel (ReactNative)
- (void)applicationDidBecomeActive:(NSNotification *)notification;
@end

@implementation RCTMixpanelBridge

Mixpanel *mixpanel = nil;

RCT_EXPORT_MODULE(RCTMixpanelBridge)

RCT_EXPORT_METHOD(getDistinctId:(RCTResponseSenderBlock)callback) {
    callback(@[mixpanel.distinctId ?: @""]);
}

RCT_EXPORT_METHOD(sharedInstanceWithToken:(NSString *)apiToken) {
    [Mixpanel sharedInstanceWithToken:apiToken];
    mixpanel = [Mixpanel sharedInstance];
    // React Native runs too late to listen for applicationDidBecomeActive,
    // so we expose the private method and call it explicitly here,
    // to ensure that important things like initializing the flush timer and
    // checking for pending surveys and notifications.
    [mixpanel applicationDidBecomeActive:nil];
}

RCT_EXPORT_METHOD(getSuperProperty: (NSString *)prop callback:(RCTResponseSenderBlock)callback) {
    NSDictionary *currSuperProps = [mixpanel currentSuperProperties];

    if ([currSuperProps objectForKey:prop]) {
        NSString *superProp = currSuperProps[prop];
        callback(@[superProp]);
    } else {
        callback(@[[NSNull null]]);
    }
}

RCT_EXPORT_METHOD(track:(NSString *)event) {
    [mixpanel track:event];
}

RCT_EXPORT_METHOD(trackWithProperties:(NSString *)event properties:(NSDictionary *)properties) {
    [mixpanel track:event properties:properties];
}

RCT_EXPORT_METHOD(flush) {
    [mixpanel flush];
}

RCT_EXPORT_METHOD(createAlias:(NSString *)old_id) {
    [mixpanel createAlias:old_id forDistinctID:mixpanel.distinctId];
}

RCT_EXPORT_METHOD(identify:(NSString *) uniqueId) {
    [mixpanel identify:uniqueId];
}

RCT_EXPORT_METHOD(timeEvent:(NSString *)event) {
    [mixpanel timeEvent:event];
}

RCT_EXPORT_METHOD(registerSuperProperties:(NSDictionary *)properties) {
    [mixpanel registerSuperProperties:properties];
}

RCT_EXPORT_METHOD(registerSuperPropertiesOnce:(NSDictionary *)properties) {
    [mixpanel registerSuperPropertiesOnce:properties];
}

RCT_EXPORT_METHOD(set:(NSDictionary *)properties) {
    [mixpanel.people set:properties];
}

RCT_EXPORT_METHOD(setOnce:(NSDictionary *)properties) {
    [mixpanel.people setOnce: properties];
}

RCT_EXPORT_METHOD(trackCharge:(nonnull NSNumber *)charge) {
    [mixpanel.people trackCharge:charge];
}

RCT_EXPORT_METHOD(trackChargeWithProperties:(nonnull NSNumber *)charge properties:(NSDictionary *)properties) {
    [mixpanel.people trackCharge:charge withProperties:properties];
}

RCT_EXPORT_METHOD(increment:(NSString *)property count:(nonnull NSNumber *)count) {
    [mixpanel.people increment:property by:count];
}

RCT_EXPORT_METHOD(reset) {
    [mixpanel reset];
}

// Push token (iOS only)
RCT_EXPORT_METHOD(addPushDeviceToken:(NSData *)deviceToken) {
    [mixpanel.people addPushDeviceToken:deviceToken];
}

RCT_EXPORT_METHOD(removePushDeviceToken:(NSData *)deviceToken) {
    [mixpanel.people removePushDeviceToken:deviceToken];
}

RCT_EXPORT_METHOD(removeAllPushDeviceTokens) {
    [mixpanel.people removeAllPushDeviceTokens];
}

@end
