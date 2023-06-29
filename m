Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BB742FCD
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jun 2023 23:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjF2V7B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Jun 2023 17:59:01 -0400
Received: from mail-dm6nam04on2079.outbound.protection.outlook.com ([40.107.102.79]:53312
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229910AbjF2V7A (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Jun 2023 17:59:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3m3vMU9BKLh+Idjy2Q1IQF7jns0tieUpgxrtD2WxboPUku2CjmUMK8CJV4P7xEUWOk31Pr2F8h3/b/9E2w7KyLgEndkUWbjBWdke7comx7nVBJWCKk+RBSXNX3H9z1LTj++i3Sb5pEHrK1kMLGReBVka0XMps3MPK5QzhlIY7i9OsgOLCjynFjk+mlO/3JO9Lr1rItnXuke5gFUkZ5g4ea0PaF4ZsqbTJMQcUE9PsxoYYYPyIr1Vrs4YtsFdUtahmbkL3djgluerdwlnsk18LK5mJBh92Wdoiiwge8W5vpyqvlWfSsNA4/UEiqyeVNBTs9Z+wQbZ/9qBC6NjSy6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCCvFK1QVBNd4lRUV9roEcIvSC7XhYlMhNSuxepqefc=;
 b=f/v0J24Ne7CcFuD9Oho8TXjMvs0tKpYwqBUYd1MMDOz82LuNR4Pt+5dc/hPweu/cv0FCafTLeAJSAH7TEZEQv2p4SI9mbuqf7oYN+gB52kbjU5S8VIsPL5B+QZmQOYitxynU0yWYDeY7swDGRob4oS7iNXSo7lzZEpZnBvJMqMY6ZQvrbSOV/i/ZparHSGZ2HEJbzLvTlN2MMjaTf2Asw9PdNoAtVnIt7gUjFkLTqTe4EVVJTUQhqZiEl5J/ggA6+jRJZ1faXvjAbP2v5fiN9Zb8p1gjaW4FXeWlgZV3ao/czwKqVnjtz4695M6XpaGI4i5ikUqCuyJw8bHOcfWsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCCvFK1QVBNd4lRUV9roEcIvSC7XhYlMhNSuxepqefc=;
 b=v+lcVHZTL9l1R/V66hhIZQQC1gXgApHaLlsn2Fy76jbUgcbPoHodzE2o4agUEsxRtzZpQtHOtukxOTUhsAuIxApRTgTecLrSEHBkaBev1uXP9QXvT+XotrYg3JQJLmv3KZ2FeE13r8rZm/n7A6IzgMVKPY8gDErqpKvQ194Xsw8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5740.namprd12.prod.outlook.com (2603:10b6:208:373::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 21:58:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 21:58:57 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: RE: [PATCH] tpm: Ensure that tpm chip has ops to check if it's
 defective
Thread-Topic: [PATCH] tpm: Ensure that tpm chip has ops to check if it's
 defective
Thread-Index: AQHZpX94aXc251l3KE2zG8dxKynyya+X50qAgAB+uQCACfiqoA==
Date:   Thu, 29 Jun 2023 21:58:57 +0000
Message-ID: <MN0PR12MB6101238A319D88DEF067FC3EE225A@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230623030427.908-1-mario.limonciello@amd.com>
 <2023062317-daytime-angles-3c5a@gregkh>
 <4d3c4b8a-1788-08af-97ef-a1466a8cda5c@amd.com>
In-Reply-To: <4d3c4b8a-1788-08af-97ef-a1466a8cda5c@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ActionId=dfe236d8-2b08-4c7e-902a-446a3c212761;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_ContentBits=0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Enabled=true;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Method=Privileged;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_Name=Non-Business-AIP
 2.0;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SetDate=2023-06-29T21:58:45Z;MSIP_Label_64e4cbe8-b4f6-45dc-bcba-6123dfd2d8bf_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MN0PR12MB5740:EE_
x-ms-office365-filtering-correlation-id: 04fcb172-b229-46e8-afcd-08db78ec0a10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /BgXIgZulm+/GExqMJY3NIFJyDE4bq55AaHotUKUAbAM8U2Nbw0Gji9RERBE/WMQw2ZJy6pUHqN3B9ew0SEM+egifN+96wsw08DP9H/c4eTQzltBR9A5P9UY5CTr+Fa3in2bQy1N/EvgOD7nxMdkn4WClxN4Hsz2hGjzoN1RfardXKZuSt37ASS2mrTNP+myTUO4aXs0XHXMP1kkizYb8fGl90nMo4u6felS7e34FGM6k97ygV8B3WaDihWvEUUJgZ2XeTWk5AH3o7uJr4KpSI1vXp0XHdO3KFdM10uzroIv3dBv9EXcjnNnvwMCCK2s0HUKRhNTf+eSHnxdvTMH+lDFO4znPU355WDP+6PYwg90BQk0uQ7teIR4AKzeC97HL23B9A3uK60TxrEP0X/VQipYSaIgwsV5GwCPPeKq2iDcusEjQRPZxFSD0c7xYlLrmTxAyxYNpcYuPuWwz772qEIr9h+Elizhk3TzzXkjVvjrHXYl39BUrbbxLUIgjCmVssGvXWQ+n91yUpHZSmB+1fYxdZNRLxXxUvipN2FzczafBtT3sFIcwhOoGW1/x7qWFbZKlOgY+bzpLeGq4VzjP9sYqEvTi7qHOCTzbhk6V+CbdihPAYDo/mCUp548Kk1mIXwY0oobOyOVom/Yt0OZyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(71200400001)(52536014)(316002)(966005)(7696005)(8676002)(4326008)(8936002)(41300700001)(33656002)(54906003)(55016003)(122000001)(86362001)(38100700002)(9686003)(64756008)(66556008)(66446008)(5660300002)(66946007)(66476007)(6916009)(478600001)(2906002)(186003)(26005)(76116006)(38070700005)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME9LckRmUHQ3VDhVLzJ6SkNXYmtVd20xSHExdjlFc29HYXMxWlBFVjVLaTZw?=
 =?utf-8?B?QUlWa3h2aTJuYXp1dmRRT2dwSHFpZlNaREo5czBqNWdwdnJPcXI5V2xodVRJ?=
 =?utf-8?B?b2xqV1hTN05qOUtYVmpBUE8xWFFWYVNZNEIwZ2tyd05kYmVudXFlWEI5SVFZ?=
 =?utf-8?B?M0dCUTFudjVJei9KNjE2c1hBOUZnU0pJaEJsMWoyL2wvaFlQaWt6bVY3V0Yx?=
 =?utf-8?B?Smpxd0VUbk9nK0RUeUlMZjE3SC8vdzNQYW05Qy8zWGJhbFBpVjNOekhTYS8r?=
 =?utf-8?B?MDdOaS9xcllEcjkxWm9ZYXJiOFR0aTlBWkRNcm5lcCtPSG5ndXJLS3ZUVHQ3?=
 =?utf-8?B?U1RCU3pIT0V3cjJSRTl6Q1RHVmdGL0pIdXo4SUhPa3JycEoybXAzcmM5cjdt?=
 =?utf-8?B?c1ZxVXRRWSs4MWNhUUdsOFdVWjNWWWt5NUFlTmRLTm04bWRNaGovdUVaZmJO?=
 =?utf-8?B?b0ptb3ZtRlprK05XUk9yYnluQjFYL2sybkwxZmNDU1E1c2J4czVpd0xlZkhF?=
 =?utf-8?B?VjdFV1dwalY3d1NUTVNvdm5LRk1xWFJqSmJGdFc2Wk44WFlkU2Y1WmFMZDc1?=
 =?utf-8?B?enJBS3kya1Z3WXVsWlhNRDJYT2JzbHIzYmRZZGdyY3JjVW4zSURtYXZERm1t?=
 =?utf-8?B?d0cveVkzaXZ0VFh4WDVvTGNrdXBaWGh3bFlMOFA5bkYwMnpJb1B6bjNVMkJo?=
 =?utf-8?B?QXBzdm5PQm9kdTAzNUJ0dWFMRXBWbVI5K2dYTmY1U2E4ZkIwSWVGbkxFVnNm?=
 =?utf-8?B?MUVaemlWVjV6WWs1NE5sRjY2WDRsSDJOd29NZGUyczRhZTkzNWRUcDF3eHRS?=
 =?utf-8?B?WnBRVkVqYVpGb2U4aGlEQmFCdGoxUG5rMmFtMzZHaERGVDg1TkNZU05mUllO?=
 =?utf-8?B?NldwVE4rWmU4cjhzN1VPSk41YUNuS2FHTEdSRlJwamc3bWdFUDJBcGp4cDlN?=
 =?utf-8?B?cytKbG04N05iQVJUQzlHaWY3emtnRkRWUUplaW5KcDZoRmE0S0V6aXVJQzVs?=
 =?utf-8?B?bFlKRDBhR3N0dzl6YktVa2ZSUFFiU0JqdGRiY0o3ZDZtdVA1SmhiVlB1ZE9w?=
 =?utf-8?B?aklyeE9ZM3BGL0ZPdTJCT2dKU3EvWHN2N3lWblBVUW5RNjhJci9EMktpMlNV?=
 =?utf-8?B?NFpBdXNmcW05SmUzalhkZTlmUEtYcXNBanZrdlIxaUtRMy9RNEg4cFZ2ZFVt?=
 =?utf-8?B?SUFmQlF0cUtFVWx6K2JHd3JhMHhqQ09NdmE2bTNpUzdtdjZvbnM5NHN5bEpi?=
 =?utf-8?B?MHhkK2ovS2w0QTRhbkd5TzY2c0ltTFQvbS90SDFZd01yQmF2MzdYYk9Fb1lw?=
 =?utf-8?B?ek9rWk5TS200Z0ZNcXFRMUNGaGxrS280SERTa1pvZW5DQ2ZkNG9oRUhFamgv?=
 =?utf-8?B?c2VIaEJKSFBCWXhOdm5USmhtME9rNTB6cERoeEFkK2tGaWxZa0tUSHFDRW5Q?=
 =?utf-8?B?cmVQVVNsRG1XemFLWGwwY3VHQ1pZbFVraldyOUJ2OEo1WkwycjZ1V0o3YmxD?=
 =?utf-8?B?U1V1Sy9pNXdQVStKdDVlOGtnMFM4L28yT2ZySnRZVHpuSUZscGs5bGFvTytC?=
 =?utf-8?B?UXdLUVNlV1JrQzlLc1poMkdLV0Y5YXQ5TjdibUFFb1BoTXUzeHdqZDdXSm1i?=
 =?utf-8?B?R0taSWgwYzRFQ2pVSU10TkVqMVZvWUxpVTlhYmFUaWxZcm1BTjdHV3lyNk5S?=
 =?utf-8?B?TitiNDk4emx2QmdBbVpndXdyczJCMnBhMU1JYkVOdzBjZWxkS0UwTlpiOGcy?=
 =?utf-8?B?YWQyRnF2RUN4VEE0aXVMdFo4aUcvdTI0K2JCcmZCYjM4MG1BZmgvZlBGQlpH?=
 =?utf-8?B?K3VJeDJTTkpCTXpTblNKNnVqeXdYODdHREdvSFJ5cGdES2hiMnJQNEZBay9G?=
 =?utf-8?B?ZjV6N0lBYUFuTTVaYTZLWWVjTElrckJ0enRuT2ZHYXJyeTYxZ0dJOVQ5N3JX?=
 =?utf-8?B?MGZlTHVlak14NjZkL3JXbDF5dTBiOXI1anV3a1pKdUhnK0tIZEJPa05pQnd2?=
 =?utf-8?B?ZldWL1U0aTZwMHBuaFlXaTVvWU5sRXNVdjUrSnNlMEpqS2JDQTYrSjJLU0lS?=
 =?utf-8?B?cVBycXNDTHBkSGNuam1RRzVZRlZsdDJMbEN3ZFFURXBjYndYWjYxNjVkMWpa?=
 =?utf-8?Q?xt7c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fcb172-b229-46e8-afcd-08db78ec0a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 21:58:57.9128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CLEHC7PSLYeR65/iTCmq6Qk3i9nFlt4J3Y40Wg3zdecK9lBShQKOc4vGAWw8RY8Qhof6oo0rfn3pYlD945K0bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5740
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVsbG8sIE1h
cmlvDQo+IFNlbnQ6IEZyaWRheSwgSnVuZSAyMywgMjAyMyA4OjQyIEFNDQo+IFRvOiBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gQ2M6IHBldGVyaHVld2VAZ214LmRlOyBq
YXJra29Aa2VybmVsLm9yZzsgamdnQHppZXBlLmNhOyBsaW51eC0NCj4gaW50ZWdyaXR5QHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGludXggcmVncmVzc2lv
bnMNCj4gbWFpbGluZyBsaXN0IDxyZWdyZXNzaW9uc0BsaXN0cy5saW51eC5kZXY+OyBBbmVlc2gg
S3VtYXIgSyAuIFYNCj4gPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tPjsgU2FjaGluIFNhbnQg
PHNhY2hpbnBAbGludXguaWJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdHBtOiBFbnN1
cmUgdGhhdCB0cG0gY2hpcCBoYXMgb3BzIHRvIGNoZWNrIGlmIGl0J3MNCj4gZGVmZWN0aXZlDQo+
IA0KPiANCj4gT24gNi8yMy8yMDIzIDE6MDggQU0sIEdyZWcgS0ggd3JvdGU6DQo+ID4gT24gVGh1
LCBKdW4gMjIsIDIwMjMgYXQgMTA6MDQ6MjdQTSAtMDUwMCwgTWFyaW8gTGltb25jaWVsbG8gd3Jv
dGU6DQo+ID4+IFRoZSBpYm12dHBtIGRvZXNuJ3QgaGF2ZSBgY2hpcC0+b3BzYCBzZXQsIGFuZCBz
byB0cnlpbmcgdG8gY2hlY2sNCj4gPj4gaWYgaXQncyBhIGRlZmVjdGl2ZSBBTUQgZlRQTSBkb2Vz
bid0IHdvcmsuDQo+ID4+DQo+ID4+IEFkZCBhbiBleHRyYSBjaGVjayB0byB0cG1fYW1kX2lzX3Ju
Z19kZWZlY3RpdmUoKSB0byBlbnN1cmUgdGhlDQo+ID4+IFRQTSBiZWluZyBjaGVja2VkIGhhcyBg
Y2hpcC0+b3BzYC4NCj4gPj4NCj4gPj4gQ2M6IExpbnV4IHJlZ3Jlc3Npb25zIG1haWxpbmcgbGlz
dCA8cmVncmVzc2lvbnNAbGlzdHMubGludXguZGV2Pg0KPiA+PiBSZXBvcnRlZC1ieTogQW5lZXNo
IEt1bWFyIEsuIFYgPGFuZWVzaC5rdW1hckBsaW51eC5pYm0uY29tPg0KPiA+PiBSZXBvcnRlZC1i
eTogU2FjaGluIFNhbnQgPHNhY2hpbnBAbGludXguaWJtLmNvbT4NCj4gPj4gTGluazogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC85OUI4MTQwMS1EQjQ2LTQ5QjktQjMyMS0NCj4gQ0Y4MzJC
NTBDQUMzQGxpbnV4LmlibS5jb20vDQo+ID4+IFRlc3RlZC1ieTogU2FjaGluIFNhbnQgPHNhY2hp
bnBAbGludXguaWJtLmNvbT4NCj4gPj4gRml4ZXM6IGJkODYyMWNhMTUxMCAoInRwbTogQWRkICF0
cG1fYW1kX2lzX3JuZ19kZWZlY3RpdmUoKSB0byB0aGUNCj4gaHdybmdfdW5yZWdpc3RlcigpIGNh
bGwgc2l0ZSIpDQo+ID4+IEZpeGVzOiBmMTMyNGJiYzQwMTEgKCJ0cG06IGRpc2FibGUgaHdybmcg
Zm9yIGZUUE0gb24gc29tZSBBTUQNCj4gZGVzaWducyIpDQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1h
cmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+PiAtLS0NCj4g
Pj4gICBkcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgfCAzICsrKw0KPiA+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gPiBObyBjYzogc3RhYmxlIG9uIHRoYXQgbGlzdCBh
Ym92ZT8NCj4gDQo+IEdvb2QgcG9pbnQsIG15IG1pc3Rha2Ugb24gdGhhdCBtaXNzLg0KPiANCj4g
SWYgSmFya2tvIGFncmVlcyB3aXRoIHRoZSBkaXJlY3Rpb24gb2YgdGhpcyBwYXRjaCwgSSB0aGlu
aw0KPiBpdCBjYW4gYmUgYWRkZWQgd2hpbGUgY29tbWl0dGluZy4NCj4gDQo+IFRoYW5rcyENCg0K
U2luY2UgdGhlbiwgYSBtdWNoIGJldHRlciBwYXRjaCB3YXMgc3VnZ2VzdGVkLg0KUGxlYXNlIGRp
c2NhcmQgdGhpcyBvbmUuDQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMy82LzI5Lzg5OA0K
