Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7809E511E55
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Apr 2022 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbiD0QRN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 Apr 2022 12:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiD0QQL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 Apr 2022 12:16:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DD24C7B7;
        Wed, 27 Apr 2022 09:12:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RDmeel003700;
        Wed, 27 Apr 2022 16:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d3ZXDW6V93xMWsL8FJ6DPShWUwNXs9V2fqxQBum5IUA=;
 b=kH0n9AZ1I5okn1AU37GK8fKgpvR9EtAtrw0cjzn1dlNspWE0BOtDtYEGrY4TtNotiRry
 8X77TXRdROEvS4YA4PM8ByGLTix3pILMuDESDJmYwv8JTKUVmw8eXZ1zHb58E/fq/1k4
 tE2rt2dRcF4l33wrHY2GLuLidAyHyvc8qXs+6AG8ks9kkU/LUhPSQr3579BB8KPynfwR
 N4mRVLPs/gdua9EEkNpKqLQLk8BJzQomnYR6KEqOyOlv8p3Phi49yoI3P6GkqLQd+CoV
 l62sx+Uyh3t49yX2mA5u2Si2zZ0GydB44y5uI8X2OnSjDYH9x8aOhAd+1nkGGaU1H/vT WQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmbb4s76g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 16:12:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23RGA9CL006282;
        Wed, 27 Apr 2022 16:12:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5200a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Apr 2022 16:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dypd8Oo5DL8JVAZ+m8JATy8jVBVF8eF0LXqIk+0b+xznnMXT0ZyY5JlkaTaFzjnrkD2i3Wn7OBRXV+3xVct8ntvbfOglYiB+AMyRdMIYZ3qVaF0FDh+9xiTmMdiAlOTbQ+s3H+UCEEW32UmCv0UoGa7SyN30LUjiii95kp7MUpTXjpwm68yc5sapMOXwLLF9vpIJGudDbdzyiidH7LEE23oTOrjczARdqIJPSWMz6rMsQ878o6lAFiXajLRDY4SqGi29ZuG75Nq4ArtL6FaY/fEOZlNGhS8HXRwtgSoGnU6YNdCXAwgpd6f44dNX0Jes/7cJCed//z2swREMtbchzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3ZXDW6V93xMWsL8FJ6DPShWUwNXs9V2fqxQBum5IUA=;
 b=IMckav9GkkB0zHpN9oCJae2gMFLVxKxCRIS0wXv8cJTgn4/m434g4oT5SNN4Ye86E8iQj4PNhxRkKiigYLdvXTlC+2tgUw5EWG2EkUSJafjiciOuxUmo4Sp9UfgK8M1bdRMZTcU8el2SIWXiN7G0P7zz6cErFpHP6HIP33LFjmar6U1wyGRe3zc8o+uwD2OO90x8xHlC/w+oS3YI94/TPbKZzfkWwdHi1DZhEAhdfbTG3yTiyBjT7tE/ogUeEq+04KaxbPagllUridYmhGRV6/f7ew0ZSqMn18u+poOQpKM0ANI3onpsc2y4n6AGXMp43hrzpClgM0zryhmG8dUSjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3ZXDW6V93xMWsL8FJ6DPShWUwNXs9V2fqxQBum5IUA=;
 b=Qh+DZA7ojVrw6uWbxrEHUXG8OEYibpCfcq8SiylubNtuC0UP1Wh7Lmvhp1sYCv3UFMLcL8W/POuQrv73o/4gLyAmZ/7D2MK1cWuEKJyl3u+ww/2uFrUyGAfda7A6vxWGAobgu0Ax+jfZ/DoqHch8Rcomi6Ggu7bLZcQMenQ8/88=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM6PR10MB3514.namprd10.prod.outlook.com (2603:10b6:5:152::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 16:12:41 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%5]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 16:12:41 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] integrity: Allow ima_appraise bootparam to be set when SB
 is enabled
Thread-Topic: [PATCH] integrity: Allow ima_appraise bootparam to be set when
 SB is enabled
Thread-Index: AQHYWPLPxIqFWJSU2kqJxJuFBPKFEq0CghiAgAFvPgA=
Date:   Wed, 27 Apr 2022 16:12:41 +0000
Message-ID: <48467663-5CD6-49C5-B43F-9FA0887D0575@oracle.com>
References: <20220425222120.1998888-1-eric.snowberg@oracle.com>
 <d7ba004bd2ce2a8ce2ff0601b4bca921a5301ece.camel@linux.ibm.com>
In-Reply-To: <d7ba004bd2ce2a8ce2ff0601b4bca921a5301ece.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d62f33-c077-4492-28d4-08da2868c194
x-ms-traffictypediagnostic: DM6PR10MB3514:EE_
x-microsoft-antispam-prvs: <DM6PR10MB3514D5910FB370311F73B50B87FA9@DM6PR10MB3514.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vUaSylw+xyPuSvPHc45IvP8yQ1CtbhBB3cLiyOvX0DkaZoMdzO4y76UyHRE3Ly3FGA3CMgWKXtEzai7B5MpBN/BM1CEdaFDODJdWWR0RT5CGGP2tV/rZZi+zO63J1ayMBY2wz6Qiyxxo2stXksrruO7muFtSAyFboGJflj9IkIbfg5w7TB0yh/KAc8PHehbh2PbHeqKYSNcCQFXL7eYuUSvhPkFJLPhigBiSfmJXytggTCsThdez7X2q3odNV0jSiqd8x5WSqveThwQ0b79C/yS6qTpFw3xFh4YRiKfw5fD2hbgcGsSj0jkV+M3zVQxluq+8Xaaz6qeBaIhamnvrO+lwE96+a/jVFC8EOPjeLmsMLd8b3TxzfYO0PRtTc1yU5UaJclCCHuBR3fih51hbmKa089prYeYM7ED6dHoodctJ5rrJE+voJumCbM7/psBlSPGPHRtqLe38iNtxQZdv/TbWPGmxfnYZe1U6p9WBqWFNMmbekKNrIb9c/AWD4bHYpL15q0SWkOFhONEPCCXiQFU85FgtP8bsOnbo9D9OY4Ovn2rLAAVzehbCypDdtW4cGep0RCqKfq/wev27nFIHYbc6pJMiFroLIjUKmgnSQ4Wzzp78CxjS9P3oK+xhtx9VDwKxCprF4BdL1dRt8dTeRxR5VWAe6FQtPCJX8VG6Hzc6638t+mWADIvVvkXJBP8ToGJeoi618nOLBQxv6/VYVCKamHvbpFxdzUj7HCv8wtk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(66946007)(122000001)(2906002)(44832011)(91956017)(64756008)(71200400001)(4326008)(8676002)(38070700005)(38100700002)(6486002)(33656002)(6916009)(54906003)(8936002)(316002)(508600001)(5660300002)(36756003)(66446008)(66476007)(76116006)(66556008)(2616005)(186003)(86362001)(6506007)(83380400001)(6512007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1NuejJndU5EdDJpUDJBZTUzM2ZkY09TUE1VRTBpWTRnaXNVVXVhUTFRM2Vz?=
 =?utf-8?B?K0IrbmlSSEt0TjRpOWM4UHBCQTlvK29RVHpLL2x0aUF0QlEzTkovY2t0aitX?=
 =?utf-8?B?ak5aZ3RvZVppcmFJZG96aXBhay9ibHVrQWZqdzhiaHVYOHZ2a1k3akNVMzVh?=
 =?utf-8?B?QlMzekthaWN1anExWTgyb2RlK1FYWmlON3pyMFdMK0lHcTZTSGRLY3E0cE5r?=
 =?utf-8?B?WTJNRGRVU2RET3ZiUWxGYk1VNjE2RlpRSHljWjYyb0JmbzM3Wm1iMG9CUG9t?=
 =?utf-8?B?TTlMOXoxRkNqZTQ4aEhKL2hrSU8yOFd5NHlocm1pVXR5K2R2QU94TUQwSmtU?=
 =?utf-8?B?MFh5Z21CNCtxL01xa05jc2I5TTV5K24ydlNSR1JFekpza2hVL1dqV3RJOVBM?=
 =?utf-8?B?R21ISTlHVkFERndBQkI1QzQ4bzgrd1JBSWp6OXk4bXVvZjFubXhtWXl5WGY4?=
 =?utf-8?B?VDhLRWtyM0JjRExhaEtjVHVNWVVYR0V5TENrbXlncmEzNWVaSEo3YUpaQUJo?=
 =?utf-8?B?LytpczU3WmIwS2NEakRLZy9uYUNJTUdsUG5HeXJyMnhzV2hBdnBXRVN6V3pR?=
 =?utf-8?B?QWpZSWF5NDNwZ0VCd091Y3pDTWZCOFlTS2dvNHMxYTJvR1daVkpZTXBqempF?=
 =?utf-8?B?NldvUkpLckxWOGs4VDBEUmhkZG1peGI1TkFKWVJBYjZ1Tlc0aVRaV3VzNzV3?=
 =?utf-8?B?Q0wyQzg0ek9LNWFjeC9PZjBkYnJNM09DZmZDS3k5bEE2RzNJdEsyK2RlZ0Zu?=
 =?utf-8?B?Zk5YZTczZzBLekZhRm5TU0ZxK0crWStwZm5hMDhSL3Q3NlczMFlJL213M2J3?=
 =?utf-8?B?UVQ5WVBvSnBRUnk2MnJpR3pPa0d2Nmk0Tzh3VlNhRmREZEJIUHJHR21jaUpR?=
 =?utf-8?B?bzdGK1ZCbWNlSDRsL1Bad1ZEeTJOdzNQK0FaYVVUUGs2VVEvMFVSaExyYnJF?=
 =?utf-8?B?ZDl6WTlUaXNYVkFseUdlb3R6TU9CUjBJMHNKQVVqeHhnVzRPdDRTNEtremJP?=
 =?utf-8?B?UCtYMUxFem0wS0Qxbzh5WXVONEVwQ1c0dXc1U0VFYnJqNWFzbUQrdG1WNVNn?=
 =?utf-8?B?ODdOakRaZ2RPR3F2LzdoUC9nbGJ3dVQzc294WE4vZHhWcnFndkxGaFZoaDZK?=
 =?utf-8?B?NXZPSE8vRjB6Qk8wM3BwWTlhaEhFRkZybmZJRGdSOVdPTjhKRGpoYllUUlg5?=
 =?utf-8?B?bFNHYmR2MGdobysvM1h0dEYyRjR2K2Z0ZkdqWHoyc1owdzhaNk9Rcmt1Wmd0?=
 =?utf-8?B?Z2FkUXYyenRJWm5leHVkMVJzbC9NcG83S2wwa0lSMjBvandnWThCaDdmUW52?=
 =?utf-8?B?NG05TkpqNlZaY0FLeUpPaE1vTUtCUlBLZWtIZGgzbjBFRDNVVmRqMzJCMmVs?=
 =?utf-8?B?MXR5djJIck14am5GaWIwM0FGM04vVVRWZ2VEZDhDeVNKMCsvb1kyZzZFNGhI?=
 =?utf-8?B?TTMzc2s4MDJsSHJXbGFPYW5wNjFNczhQTWtpZFRJcFVLK1RlaUc5NEF2a0pt?=
 =?utf-8?B?US8zc2g4eGhlanNEQWpWYnp2aW84cHRpUnI3TDhDdGM4R2QzUnZMdk94TkNl?=
 =?utf-8?B?anZwNGtHVFNRZlc3VTAvb3UwZ1MwWjcwNHBUSXJXcjE0ME9BRkx3M0wrcXMr?=
 =?utf-8?B?K2RiUkVTRWVBVS9kdDVoMHdudjJabUQya1RHZHc3U3IxbDkvdnFMVFJGNENv?=
 =?utf-8?B?NVRzbEMrMnMrb1JobURTbUhZbFI0WEVVYmR1WTJZajR2V1AzcTNqNklsWllK?=
 =?utf-8?B?WGg3Tk9VdzJuREVxUUJwVWt3UFZlK1QxT0tOMGJUSUs5KzUraVNKR2tteStl?=
 =?utf-8?B?U1U5WVR5akxxNmN1T2NOd2lRWlB6Si9jQThFL0J3RUIvbTYxUVlndnlQQm1V?=
 =?utf-8?B?QzltdWx5bmFYRUJGZUFBSUtKaWhLTFhJZ3NBclJqRXZpdDY3YVFNdTIzaStY?=
 =?utf-8?B?WjVWaDlpejJJS0RReDc4bXhhcjhjNUNpOGlaUUJFaXV1dit3UzVjcXljQnVX?=
 =?utf-8?B?RnFiUm8vTmVGTVNxWDU2bHh5bUtHUmU2RjF5QkVvZ2tSMGRNTFgyQ2d1QmdS?=
 =?utf-8?B?ejk4S0VkY3FXTlBOT3pFVVVRZVZKK1IrZ2dXd0RzNVJsTU1xMTIzSG5tK1hE?=
 =?utf-8?B?ZGdYS2FveU5nYmI0NlJaWXQrN1AxTDFsNnduUlVFdCt3b1llTktxbFZwYm5O?=
 =?utf-8?B?ckg0L0lCNGluRC9jbHBhRVdnL0xGRkd4K2pNUDNSVWJsMlgxK1dhNS9BMGto?=
 =?utf-8?B?eUhheVlFN0NoMytsQzhCQ1I3ak1jd0I2VFdQVzFnK1J2Vm9RNXRlZDgzRWlz?=
 =?utf-8?B?TDNjcTBMdWUvd2k3S1U2L1RETThDU1VkYjlZYWY2S1ZRaXo3S05ZTWVJa2tC?=
 =?utf-8?Q?22APGl2waWaN3BRdre6KPa/LhMeoUK7aWyXaCmnzrwn4K?=
x-ms-exchange-antispam-messagedata-1: Zoe2DonthtNQ2w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7105AD430EE5924A88051975040E2DA8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d62f33-c077-4492-28d4-08da2868c194
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 16:12:41.5456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Jgy1N8aGTpU3XgiU1mNBbRaDTk2hghkWwTsDCU21R3IjEdbQUD79i3UqhyiAkq279BTVBkavMaeCoCPboeTmrwqNEP3YVMa9yOMJkRBKJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3514
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204270102
X-Proofpoint-ORIG-GUID: _Zq3ZRzei3fVl53QI0P_fvfuaGEduMvI
X-Proofpoint-GUID: _Zq3ZRzei3fVl53QI0P_fvfuaGEduMvI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

DQoNCj4gT24gQXByIDI2LCAyMDIyLCBhdCAxMjoxOCBQTSwgTWltaSBab2hhciA8em9oYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIDIwMjItMDQtMjUgYXQgMTg6MjEgLTA0
MDAsIEVyaWMgU25vd2Jlcmcgd3JvdGU6DQo+PiBUaGUgSU1BX0FQUFJBSVNFX0JPT1RQQVJNIGNv
bmZpZyBhbGxvd3MgZW5hYmxpbmcgZGlmZmVyZW50ICJpbWFfYXBwcmFpc2U9Ig0KPj4gbW9kZXMg
KGxvZywgZml4LCBlbmZvcmNlKSB0byBiZSBjb25maWd1cmVkIGF0IGJvb3QgdGltZS4gIFdoZW4g
Ym9vdGluZw0KPj4gd2l0aCBTZWN1cmUgQm9vdCBlbmFibGVkLCBhbGwgbW9kZXMgYXJlIGlnbm9y
ZWQgZXhjZXB0IGVuZm9yY2UuICBUbyB1c2UNCj4+IGxvZyBvciBmaXgsIFNlY3VyZSBCb290IG11
c3QgYmUgZGlzYWJsZWQuDQo+PiANCj4+IFdpdGggYSBwb2xpY3kgc3VjaCBhczoNCj4+IA0KPj4g
YXBwcmFpc2UgZnVuYz1CUFJNX0NIRUNLIGFwcHJhaXNlX3R5cGU9aW1hc2lnDQo+PiANCj4+IEEg
dXNlciBtYXkganVzdCB3YW50IHRvIGF1ZGl0IHNpZ25hdHVyZSB2YWxpZGF0aW9uLiBOb3QgYWxs
IHVzZXJzDQo+PiBhcmUgaW50ZXJlc3RlZCBpbiBmdWxsIGVuZm9yY2VtZW50IGFuZCBmaW5kIHRo
ZSBhdWRpdCBsb2cgYXBwcm9wcmlhdGUNCj4+IGZvciB0aGVpciB1c2UgY2FzZS4NCj4+IA0KPj4g
QWRkIGEgbmV3IElNQV9BUFBSQUlTRV9TQl9CT09UUEFSQU0gY29uZmlnIGFsbG93aW5nICJpbWFf
YXBwcmFpc2U9Ig0KPj4gdG8gd29yayB3aGVuIFNlY3VyZSBCb290IGlzIGVuYWJsZWQuDQo+PiAN
Cj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgU25vd2JlcmcgPGVyaWMuc25vd2JlcmdAb3JhY2xlLmNv
bT4NCj4gDQo+IFNpbmNlIHRoZSBJTUEgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIHBvbGljeSBydWxl
cyB3ZXJlIGZpcnN0DQo+IHVwc3RyZWFtZWQsIGVpdGhlciBlbmFibGluZyBJTUFfQVBQUkFJU0Vf
Qk9PVFBBUkFNIG9yIElNQV9BUkNIX1BPTElDWQ0KPiB3YXMgcGVybWl0dGVkLCBidXQgbm90IGJv
dGguICANCg0KSSBkb27igJl0IHNlZSBjb2RlIHByZXZlbnRpbmcgdGhpcyBhbmQganVzdCBjcmVh
dGVkIGEgY29uZmlnIHdpdGggYm90aCBvZiB0aGVtDQplbmFibGVkLiAgSXMgdGhpcyBhbiBhc3N1
bXB0aW9uIGV2ZXJ5b25lIGlzIHN1cHBvc2VkIHRvIHVuZGVyc3RhbmQ/DQoNCj4gVGhpcyBLY29u
ZmlnIG5lZ2F0ZXMgdGhlIGFzc3VtcHRpb25zIG9uDQo+IHdoaWNoIHRoZSBDT05GSUdfSU1BX0FS
Q0hfUE9MSUNZIGFuZCB0aGUgaW1hX2FwcHJhaXNlX3NpZ25hdHVyZSgpIGFyZQ0KPiBiYXNlZCB3
aXRob3V0IGFueSBpbmRpY2F0aW9uIG9mIHRoZSByYW1pZmljYXRpb25zLiAgIFRoaXMgaW1wYWN0
cyB0aGUNCj4ga2V4ZWMgZmlsZSBzeXNjYWxsIGxvY2tkb3duIExTTSBhc3N1bXB0aW9ucyBhcyB3
ZWxsLg0KDQpJIHdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgcm91bmQNCg0KPiBBIGZ1bGxlciwg
bW9yZSBjb21wbGV0ZSBleHBsYW5hdGlvbiBmb3IgbmVlZGluZyAibG9nIiBtb2RlIHdoZW4gc2Vj
dXJlDQo+IGJvb3QgaXMgZW5hYmxlZCBpcyByZXF1aXJlZC4NCg0KYW5kIGFkZCBhIG1vcmUgdGhv
cm91Z2ggZXhwbGFuYXRpb24uICBUaGFua3MuDQoNCg==
