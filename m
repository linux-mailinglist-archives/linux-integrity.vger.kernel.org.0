Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147FA743B9A
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jun 2023 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjF3MKG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Jun 2023 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjF3MJl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Jun 2023 08:09:41 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564E64498;
        Fri, 30 Jun 2023 05:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnfj9cFOc1bQ88JlKX50R5W9jDrUisYb1ZUNnJ0MrdhYsHIblWMlKHYaMmh+blrrt9CjpmCts5qXKBmPjUgb+y3eXnx4Us5l2OhZIsbXwqeSLkP8VVTipRON4dxrjIpj+6ou1lHq3E5iC/sWSdkBI5pwPSpya+hpDkpwIPHE0TLoYdPgPkO8vmAb4jbdBVGnXBk4khoVBwv8M4oVWZpQ4NsdZHKB+Z5MyRJOOMZCEG/O61NTkW4T7juVHUQ4NVELrTuA7UUWYyl7lU3JxMb1UVTgcDMsz2eSfbeYft3bgmKsktL1zqMpamyKKkdSGc6dGsyMaW3zMVzSf2MuFc+01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Jn8QMg9xkOWBVvoJPVhcqE6WAzbtjPoUmNVxilc8sg=;
 b=eK8m/yiokMrjT1TLWn2vthCDqoYG8gu2S6A3a0Kvtpu2oPgaq5QcsENkhspvNhwPMTETeY0wESBhDqXR+ntpKZ59SzwK6ys/MulcV8OA7R/ySZZQb7i6sgAvk3eIR2pv80XjVErVHws1z6wodA1hKqYBaqk+pOFiAYODGPgH2sbocJV7XpVRwTDyTqkBsbW9tEsxRnJFW0czhB1uxlO5zroN1O7M0y+Ug/vEGMhssafaqAFEynv+0CpiRIxSkzxnMDmchsl5BccvrCDd90Tn4C4G7YaNCW+CXn9t+g/JuCs2D4fOYGd+BEpHnkWsYCDMMaMudxEXtqLi3NjkoqNWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Jn8QMg9xkOWBVvoJPVhcqE6WAzbtjPoUmNVxilc8sg=;
 b=q1Mge9k8aoXdWWqn9IJaND+cu2mxKI37Hs5Ubst0y2unvblQf/d6MIAlnYkScQ3bRL5Mvho0Z4fTvcS5BnujNIfwDFX/9T71Tqm5XmAu3cx72qkKUbt0KyZF3yWklS+CkJyef4qt6UBcTjwJzyWt0qiMltVEMb+nZy3WxWB62k0=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 12:08:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::dfcf:f53c:c778:6f70%5]) with mapi id 15.20.6521.026; Fri, 30 Jun 2023
 12:08:31 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Sachin Sant <sachinp@linux.ibm.com>
Subject: RE: [PATCH] tpm: return false from tpm_amd_is_rng_defective on
 non-x86 platforms
Thread-Topic: [PATCH] tpm: return false from tpm_amd_is_rng_defective on
 non-x86 platforms
Thread-Index: AQHZqsonN6ZGMZJTmkWZ6qg91Llur6+jH6MAgAAh5ZA=
Date:   Fri, 30 Jun 2023 12:08:31 +0000
Message-ID: <MN0PR12MB61018706857B2034ECD3189AE22AA@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230629204147.1852823-1-jsnitsel@redhat.com>
 <CTPWGNGECE0A.7MSU6S60YWDK@suppilovahvero>
In-Reply-To: <CTPWGNGECE0A.7MSU6S60YWDK@suppilovahvero>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=35f19610-7e1a-4fdc-9b19-d2cd7e22ffa1;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-30T12:08:24Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5663:EE_
x-ms-office365-filtering-correlation-id: 214f5bd7-6a44-43b0-5248-08db7962b8db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +tFJWQyf/XmUVovn4ukmwqlrxphmft4EeL3JMqOJi1CKD47paRnQ+6ZN7FsgVaZBXrb1Fe4m0LWg0kHQcbg6Ky2FgvwDxbbFLJcm7dllopHa6Lycdyh1sH+iWw3HdWCKWDbF+f5HJCq+3IMWCQspbUsVw5yYlfJ6Mi2T4dIe0dkVzGnZ6m13rbhcUTzbpH2Mxw8E4jJYx8SObkAkgJamjhMasujw2hUX8dP7/Ri6eD8EsbeIP7XkV0zJhTXonpHTcqCyJ44andVJs4LmzHpo0LmQ6OXIZpEQIQkCh1huo3h9Zb1nnYEBdsD/afrU4t6JcVSUTMNzRlQ70aFWd7CXLX/k6RiBAErla63fTyAb/fTBDFc8Xd4NRd66Ii7dNksnGLWLPTqJeZ/MLj8NhH6yXVHiCRavwh+AlbZQv9AamZ7zQAXX8H7z1tcZTm5ndif/UyDX9QXQ2bbO7ASefkUEsGm3gw5VtJW5bQgpEFt6G0UG/4Z+2jodMCm6Tz3l2LFaxoG/OFGH+iBsJX7OWN5/iKnAs5UGvV/2xaAKvb2UuJIkFzP+aW/4GovAUsiUl/sKXOTFaDoAUatvVYZVBrdWwAgDyUk6shOky28XFqs8GFg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(66446008)(66899021)(38070700005)(8936002)(9686003)(26005)(66556008)(4326008)(66476007)(66946007)(7416002)(86362001)(122000001)(41300700001)(8676002)(316002)(55016003)(76116006)(52536014)(5660300002)(64756008)(38100700002)(110136005)(966005)(33656002)(6506007)(2906002)(83380400001)(186003)(71200400001)(53546011)(7696005)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDltdUMvNTA2VzF4bmdDRWppK00vMVNRM2c3QzZjL0RpWFM1Q2sxQVlPMXRi?=
 =?utf-8?B?QUU3WGdoMWhKU1ZIREF6WVFCbmg1UW1BUFBnRUQ5K0YvVkV2cjNYaFRlR1lH?=
 =?utf-8?B?bXgrUm9wdnI4N3VRWDV3Zm1hZVFSUnpZbWVjdUhxV1ZPNFozY2NqWlJ6Vy92?=
 =?utf-8?B?SGZCeU1VdDRwOGJJTk9yb0dpQ3RjY3FSOThrM3E4VEZXL2lNaGJXTW4rVmNp?=
 =?utf-8?B?SzJrVm0wRGJBMHpyd2JCNzBkZ2xZc0FRYlNlZ3dlVEkvd0NjcGJQNnoyVFA0?=
 =?utf-8?B?Nkt0anRQS2poZy9xaW4rM1FLbWsyY1Vya3RMa3BCMXdFMmt6dzFVbjI3VmR6?=
 =?utf-8?B?eTFpdEpLWU9rbjRvdUhublVFaU5nRFIrL2FKMkRRSHVsMzIyeDRBeXZkbmhs?=
 =?utf-8?B?akM4UEc4bVhmMHhoV0MvNTUrQ05Vam13TituRlFHZnYzRkk1WWhMVEdycFgv?=
 =?utf-8?B?elBhc1lJMG5IYnVRUENFY1VtQmpCd0Roc2xJU0pCblJkVEE1MkxwNjM2V0FQ?=
 =?utf-8?B?UkVROTQ2TVdKRjl6RGJ5ZzVpaHNBWE5oTXJYZjdkNzBvcDVmcWZ2SUY0VjlR?=
 =?utf-8?B?R0FTR28zTjgzZW1XSTIzSWFuVElWcGdtdVJDbDcvam5oeUhHejdwRjhsV0pH?=
 =?utf-8?B?aGJzV1FwV2VWYXNlQ0FMTlNWVkNJaVE3RjRZNkFoOGhhUUdLUEZMRmMvVlZj?=
 =?utf-8?B?R2V5RTNQWGVYZ0h3eTd0Wnk2SW1JeXZ1UExRdVU3dytaQkRwejNkbGJ3bWcy?=
 =?utf-8?B?QjBJNjVsbG1jaTUwcEdveUIwR3hBbDlSQjk0eFVNVzFGelczTkUyYWF5L3l3?=
 =?utf-8?B?Zng2Y1BsOHN6cU9mZkgxdTFZUU8wZkJ4Z0VQMm12RHBJQVRwMEJHY000a2Vl?=
 =?utf-8?B?OTJjN2tBb0RGN2pkazFlUTBzdjdTbTlTdUNKQ2hkVUQ5ZjZPcjFXWnhYRzdn?=
 =?utf-8?B?QUlrVGM4K3FXT082clNHU1UzUzJ0bjhWSk02cG82SHB3VlFBMldLZDFPQTll?=
 =?utf-8?B?Z1hra2ZoY2pyWEJxeGdHQVd2d2pOdUg2ejdCYXRFcFl2N1dLaGgyYy9aVUhG?=
 =?utf-8?B?bG1JTEVxeldMYzZEV1N6bjM0eXRxQlVZRFhsUHc2MU5zTENmVi9JZFN0S21V?=
 =?utf-8?B?Y0Y5OXNwS0NZSmFac3Z4bzZkYmlqUnJlanFxMU5wakdwdW5XRS92cmlZc3dX?=
 =?utf-8?B?WUNlY0NnQUlQNFgzcWdYTVhzQjNhdXVUR3o0T1daQWNsSXhKdnYwQ0FENW53?=
 =?utf-8?B?UmV3MDcyZ1hscjdUOFRINk5lbFlabGhDZzI2bWxJTXlEMzAzTWFPTzIxMDNy?=
 =?utf-8?B?Nmh5M0RLTThMQU1sTGc1aWx3M2xpbDlRaDkySGp2TDBSNVErbmhBSTBmZTA3?=
 =?utf-8?B?dFJ2QWs0QXRRaE56MUwyb01KQVg2YWk3ZCtsR09lZk5ndnpmY05WUDdkalIx?=
 =?utf-8?B?b0hqU1J3WVpEUThqM1JEMU15bUNvMmhhRTNqci9nb09vRTBGaHRhOVdmU04y?=
 =?utf-8?B?RGVXeC9FTXVOTlNzdWN6MCs4VUtaTWhncUpJTE56WUVQR3FLVTJCdnhkWDJF?=
 =?utf-8?B?ZEZncDBrUU16dDBuU1F6UVlrdnRVaHlNNnVmRmVpSFBrNUZDeU5WejRVVHBL?=
 =?utf-8?B?b1VmMDcxbTRtYkljb3pKbXJNK2pLQ0J2N1BRbEhOT3FpUHlONm1LRDZMa0hu?=
 =?utf-8?B?N1dMWnltSS9NNDB4eTFwMzZpU0JlQ1VsNWRaMFhIZjBsaTlwY2Z4N3p1WXVE?=
 =?utf-8?B?bzhid3Vpa3pzdmhkdGZwOGNHTTN5UFJZY01lS0RZakg4YlZqaVRRU0JnL1M1?=
 =?utf-8?B?UVpOQVBHMFI3c0ptSDRNL0FjaEcreEdnc2ErSDZ1cmNRcXErdkNXUU1SWnhw?=
 =?utf-8?B?akp3TlVqS0JZR1BSMXA3MklyZVlGNk96U2oyOVJrYXYvR2UzM3RibkdDSUJ0?=
 =?utf-8?B?UlE4VzRrUExlbjVvdlBUcW5nZVJjTlV4c0hIZTQ0ZHBVRGpSOGlRUldsWEJI?=
 =?utf-8?B?elAwRWJWUmN1WmtGSUErQm9xRDZqV2RmR0ZsakxQM2pya3JiTXlxL2k4OHl4?=
 =?utf-8?B?eFU0Q01RQlJ2RTVDMkpwa3BMeUI3aWlmOFUwQTNCdkZPeDQwKzg0SnUzaEQz?=
 =?utf-8?Q?tikE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214f5bd7-6a44-43b0-5248-08db7962b8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 12:08:31.8010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlVSDTlnqx/CBqvN0n6yj23kMpEExvxK5D9AjEp997y8G5hC414jaV6tUbJwUWcHf6Y+ZXOEY2GjsnGPQEZuIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYXJra28g
U2Fra2luZW4gPGphcmtrb0BrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgMzAsIDIw
MjMgNTowNyBBTQ0KPiBUbzogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVkaGF0LmNvbT47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWludGVncml0eUB2Z2VyLmtl
cm5lbC5vcmcNCj4gQ2M6IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPjsgSmFz
b24gR3VudGhvcnBlDQo+IDxqZ2dAemllcGUuY2E+OyBQZXRlciBIdWV3ZSA8cGV0ZXJodWV3ZUBn
bXguZGU+Ow0KPiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBMaW51eCByZWdyZXNzaW9ucyBtYWls
aW5nIGxpc3QNCj4gPHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldj47IExpbW9uY2llbGxvLCBN
YXJpbw0KPiA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT47IEFuZWVzaCBLdW1hciBLIC4gVg0K
PiA8YW5lZXNoLmt1bWFyQGxpbnV4LmlibS5jb20+OyBTYWNoaW4gU2FudCA8c2FjaGlucEBsaW51
eC5pYm0uY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSB0cG06IHJldHVybiBmYWxzZSBmcm9t
IHRwbV9hbWRfaXNfcm5nX2RlZmVjdGl2ZSBvbg0KPiBub24teDg2IHBsYXRmb3Jtcw0KPg0KPiBP
biBUaHUgSnVuIDI5LCAyMDIzIGF0IDExOjQxIFBNIEVFU1QsIEplcnJ5IFNuaXRzZWxhYXIgd3Jv
dGU6DQo+ID4gdHBtX2FtZF9pc19ybmdfZGVmZWN0aXZlIGlzIGZvciBkZWFsaW5nIHdpdGggYW4g
aXNzdWUgcmVsYXRlZCB0byB0aGUNCj4gPiBBTUQgZmlybXdhcmUgVFBNLCBzbyBvbiBub24teDg2
IGFyY2hpdGVjdHVyZXMganVzdCBoYXZlIGl0IGlubGluZSBhbmQNCj4gPiByZXR1cm4gZmFsc2Uu
DQo+ID4NCj4gPiBDYzogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4NCj4gPiBD
YzogIkphc29uIEEuIERvbmVuZmVsZCIgPEphc29uQHp4MmM0LmNvbT4NCj4gPiBDYzogSmFzb24g
R3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+ID4gQ2M6IFBldGVyIEh1ZXdlIDxwZXRlcmh1ZXdl
QGdteC5kZT4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IENjOiBMaW51eCBy
ZWdyZXNzaW9ucyBtYWlsaW5nIGxpc3QgPHJlZ3Jlc3Npb25zQGxpc3RzLmxpbnV4LmRldj4NCj4g
PiBDYzogTWFyaW8gTGltb25jaWVsbG8gPG1hcmlvLmxpbW9uY2llbGxvQGFtZC5jb20+DQo+ID4g
UmVwb3J0ZWQtYnk6IEFuZWVzaCBLdW1hciBLLiBWIDxhbmVlc2gua3VtYXJAbGludXguaWJtLmNv
bT4NCj4gPiBSZXBvcnRlZC1ieTogU2FjaGluIFNhbnQgPHNhY2hpbnBAbGludXguaWJtLmNvbT4N
Cj4gPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvOTlCODE0MDEtREI0Ni00
OUI5LUIzMjEtDQo+IENGODMyQjUwQ0FDM0BsaW51eC5pYm0uY29tLw0KPiA+IEZpeGVzOiBmMTMy
NGJiYzQwMTEgKCJ0cG06IGRpc2FibGUgaHdybmcgZm9yIGZUUE0gb24gc29tZSBBTUQNCj4gZGVz
aWducyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmVycnkgU25pdHNlbGFhciA8anNuaXRzZWxAcmVk
aGF0LmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jaGFyL3RwbS90cG0tY2hpcC5jIHwgNyAr
KysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMgYi9kcml2ZXJzL2NoYXIvdHBt
L3RwbS1jaGlwLmMNCj4gPiBpbmRleCBjZDQ4MDMzYjgwNGEuLmNmNTQ5OWU1MTk5OSAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbS1jaGlwLmMNCj4gPiArKysgYi9kcml2ZXJz
L2NoYXIvdHBtL3RwbS1jaGlwLmMNCj4gPiBAQCAtNTE4LDYgKzUxOCw3IEBAIHN0YXRpYyBpbnQg
dHBtX2FkZF9sZWdhY3lfc3lzZnMoc3RydWN0IHRwbV9jaGlwDQo+ICpjaGlwKQ0KPiA+ICAgKiA2
LngueS56IHNlcmllczogNi4wLjE4LjYgKw0KPiA+ICAgKiAzLngueS56IHNlcmllczogMy41Ny55
LjUgKw0KPiA+ICAgKi8NCj4gPiArI2lmZGVmIENPTkZJR19YODYNCj4gPiAgc3RhdGljIGJvb2wg
dHBtX2FtZF9pc19ybmdfZGVmZWN0aXZlKHN0cnVjdCB0cG1fY2hpcCAqY2hpcCkNCj4gPiAgew0K
PiA+ICAgICB1MzIgdmFsMSwgdmFsMjsNCj4gPiBAQCAtNTY2LDYgKzU2NywxMiBAQCBzdGF0aWMg
Ym9vbCB0cG1fYW1kX2lzX3JuZ19kZWZlY3RpdmUoc3RydWN0DQo+IHRwbV9jaGlwICpjaGlwKQ0K
PiA+DQo+ID4gICAgIHJldHVybiB0cnVlOw0KPiA+ICB9DQo+ID4gKyNlbHNlDQo+ID4gK3N0YXRp
YyBpbmxpbmUgYm9vbCB0cG1fYW1kX2lzX3JuZ19kZWZlY3RpdmUoc3RydWN0IHRwbV9jaGlwICpj
aGlwKQ0KPiA+ICt7DQo+ID4gKyAgIHJldHVybiBmYWxzZTsNCj4gPiArfQ0KPiA+ICsjZW5kaWYg
LyogQ09ORklHX1g4NiAqLw0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgdHBtX2h3cm5nX3JlYWQoc3Ry
dWN0IGh3cm5nICpybmcsIHZvaWQgKmRhdGEsIHNpemVfdCBtYXgsIGJvb2wNCj4gd2FpdCkNCj4g
PiAgew0KPiA+IC0tDQo+ID4gMi4zOC4xDQo+DQo+IFNhbml0eSBjaGVjaywgdGhpcyB3YXMgdGhl
IHJpZ2h0IHBhdGNoLCByaWdodD8NCj4NCg0KWXVwLg0KDQo+IEknbGwgYXBwbHkgaXQuDQo+DQo+
IEJSLCBKYXJra28NCg0KVGhhbmtzIQ0K
