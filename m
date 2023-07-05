Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAB748FD1
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jul 2023 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjGEVcN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jul 2023 17:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjGEVcL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jul 2023 17:32:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E461BF6;
        Wed,  5 Jul 2023 14:30:59 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365L4kSS006690;
        Wed, 5 Jul 2023 21:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JLPKCFwkJLuXER0Gsrm2VneeBze553x1o+tN2wqgPpk=;
 b=r+Isf0A2lmvuYbb+DRV86E9BALU7b/ZzipcPaPsq8Y2fishnBMOzjxd0lYnMfd488L0u
 8UoiyQNR9q1pj/aR/iD7YjQTRChlxVA2yQ6X0HZZcP2cJ7kaHLTzDVthjbB9CtSQrF6t
 kwEfBPMnZEdH/I2QLTDLZk2HSmaYkY+kRCjNASOY6amSdm1/HJwLDQWcZNmEQUgZh3cu
 RrfOXRE4LElEpJujC475kpr8WZi/h/69ONLBNPTABa5URnn0Y1PcdmtbpwQHfUL1GdFx
 vBPWVD5CZmajqtad2pqstF+PCL/k//Gwy3S/8DTabsnd/dIVqRS0jUTueFVtTT7pYA9W lw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnf1385uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 21:30:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365KfZDd024636;
        Wed, 5 Jul 2023 21:30:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak6mk5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 21:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBOsWER5hwppNBkxu5st3ijF5WOeHdZZyG+VwEVjtOpY1GmeTJVXxM4c6IlNhqhwUCTowRAt/3XPQ2Bn9C5C+rBvuVFskmyw6bmDBgpGGp4Himm7Vz/zFowlNNmdEg3swucOxqcavrz4SlaOSMFLCTTJagbYo40+xxL1Vq2soJnyYryusQBYj1ooM+C2KuoLisfPy0d1NlnTNBC6+jwEtGv3UzRaDO9nVva5EnLp1dFpFl6incZswYvt983x87XihCwdqH3GJ077BCEJ46yRcFAp1lw/BOrof+l51tFYMr9FjxLNeQav4s2pTqd3/WqHGWPXseLsQdx8LLUyJ6pV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLPKCFwkJLuXER0Gsrm2VneeBze553x1o+tN2wqgPpk=;
 b=F+GHJ8i2V9eHDXD61ExaQaW+oQMpOX3F5Sy/PXcOecBYSWNBmDjPvIkO0ZcOiLF9gcl5pB7mcuyg6eI4xzJVk0VQBKkoYSZQkYWI/L575b4gF6l5h+iyJoFWZP7KNOmxH06FdmVu1QokRjdmbvSBjtvOBN5juDyHC0MZJ/jrd2NGjLoh3kHaLUoe3jQz8bK9kx5NUI9px3VaKBtv00oCCWvBujsCb+YGig9mxct06LXMiMugPnuXOVDuQoRMHjtrDjEAjKXnoovAhrnoovKUrcyOdNajRqKir/Vmj7jgmluYMx3VOukwL4SQ9wl32XvAOuPd9DAN3lXfNkz0wWKzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLPKCFwkJLuXER0Gsrm2VneeBze553x1o+tN2wqgPpk=;
 b=aJosbvoOYRQanoqThNhZ1u4sDV/dO4boAUKIDStdPPMpWXvTpIQAIrHDL+ItMt4H8pF+2npsfc36pfh7AErR1PDJ+mGc7OtTXVWmoX7i/E6M8jMCcJVhX7Ujd3+tZTxDEQ+K6tVzB0WPP6lO2KgYtAHJdXWCa0VjBORToHERED4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH3PR10MB6904.namprd10.prod.outlook.com (2603:10b6:610:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 21:30:36 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::6fe7:599d:4540:5ec1]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::6fe7:599d:4540:5ec1%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 21:30:36 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH] integrity: Always reference the blacklist keyring with
 apprasial
Thread-Topic: [PATCH] integrity: Always reference the blacklist keyring with
 apprasial
Thread-Index: AQHZq3SR3Vrg3SdHi0+F3eOSTb15sa+pj8WAgAIpLAA=
Date:   Wed, 5 Jul 2023 21:30:35 +0000
Message-ID: <FFC9574D-4788-4583-A334-76BE9684A8D1@oracle.com>
References: <20230630165712.909767-1-eric.snowberg@oracle.com>
 <559d380a557c2ee210c808481a1cb92e5afe6c61.camel@linux.ibm.com>
In-Reply-To: <559d380a557c2ee210c808481a1cb92e5afe6c61.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|CH3PR10MB6904:EE_
x-ms-office365-filtering-correlation-id: 563388f0-d933-4279-9549-08db7d9f11fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bclhmC2JtPHB5BCUGxRl6B3tX2+9axZwDurNhfHiOZ2TWqcxaadiFIm9jcWOB8S8hJfMdAISB8wb4ohs3coLyzsF9s2waD9Yz5ISNexvS8SyGkWTeje+b1CScZP7YH1EsPWdFGr6/yb/m/JCWYGCGRZ8ndLDfjzGvNVOv/XQNHkaRsOkurJ6Ze+uEy7kKtrThY4nSTum2jASdJ5mfgsyz/TzVK25/lQt6SynX01WBX8ltfUtDakzYmWr9wGfS/CotS7a38eanAqA0us4+rTNbAEO7Sv5jXJ3BHqK3dBeenu7g6AoMmnggKBUMtoq7olRxDeV6egPuvEXjJ+trUGRxqc5qkyGR6QPmOp7RNkqKT7tNkrewWyQpaKi0ui0YkGqPOkAl/9OWxXkUkQf7OyVt/dr429f84CbOs6CTv3hQpf7Y/bdNVuCjMvv+Mm+qc5n9UfECaXmIGbGEJpwNYMG0L9Pnb5asM2337kXoNWEztCOcfkfHL/Tw1HDLX9fYKOHNwOfIZzs1/p7BzJlflGMHUyukLMdzAE33I3KRuydLkNvY6/i6z/ZiYj3rrasrKrwrbxe6mNa4yclEoFgtXb+nVCpi5+QOKp5JiD7xrT/DUP6v4ecxxuFE5yAUiqIUiirg656qevh2ZaBYsJ+9frTSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(6486002)(478600001)(6512007)(54906003)(2616005)(86362001)(36756003)(38070700005)(83380400001)(2906002)(186003)(71200400001)(53546011)(26005)(7416002)(6506007)(122000001)(66946007)(316002)(76116006)(66446008)(558084003)(38100700002)(41300700001)(33656002)(5660300002)(64756008)(44832011)(66476007)(91956017)(66556008)(6916009)(8936002)(4326008)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uei6w5OChszJGioVkEKOhkcxRdFVHZgZWitckWvSdUyHyLQpMA9IKR8QLcwI?=
 =?us-ascii?Q?oR6SG77ZpOuDTrIOGYu6Gltmowwkw6T+0F32eWrZgFNTMCPti5o9FFIYcdkx?=
 =?us-ascii?Q?D6qjCLRFM/JvuaBouUKqkX/2KG/S1xs4TrSF4SSy3zyIt/un/wPaRFnr6Z1x?=
 =?us-ascii?Q?nfq+PrzLIetNsRbNEb5gpFMBlXeTsLQctEQqoU2dBKyA7xK2HHQigIQNvNOg?=
 =?us-ascii?Q?KfLS/Fkdm0wd96d4HlITgWCEteUaHqYDwC9lDvkOlORZmmODM6gNRuqr4Evz?=
 =?us-ascii?Q?GMtY2k8cLGVVWZLqzLv8PKnnUFU7OjC/xiwuaeA5ih6+Ln7gj+aPwfMkw7Li?=
 =?us-ascii?Q?4+73K69a49TBZ6BVnEJ6Iu6NbbFfMgIA0kkHoU0KreQOviXczcyDInxREpiJ?=
 =?us-ascii?Q?W9JO6rSufHK3T3U//ce5jtx4W7Z2UJaFM3eF46GDcRiyg5/bsBPuyAP4nX0L?=
 =?us-ascii?Q?LG1K9SVpurM4jYYmg9rBJrVjk9Bs31yc4YpWxOoyy3ERr3+sBUjHQEwtkKtR?=
 =?us-ascii?Q?94wbna8SsBOoS+nOXOnT58xIuVXZS/sE/+hGZl7t8XiJ+uW5I0ZgYx834Rfr?=
 =?us-ascii?Q?NF4uMRh8QKMt4rw8a5PhxYDeLN/ZpxGQ0sr5aSP4o3C7Kco+vrH2+YCwLmeb?=
 =?us-ascii?Q?xf1lwE1AeFIrnJVGy4qh3Rzr+Y28IqaP4f9jZSFdsaNgT/3daQJaYKeiZHYA?=
 =?us-ascii?Q?kNADTUfu3e7mQwQabq40CQ3cT3WoRAJh8aa2L2gH8oq23lkNa3wVKisp2G7K?=
 =?us-ascii?Q?5vMcXejBb9+0z2kePs1zwAmbgH8fhcpIq7J7cPA6JZ/rsAn2n8/dH7mI/hzO?=
 =?us-ascii?Q?rqB08MiNTEHKjyj5+/gdJdbItBONuccKWYiDN+JYftRr4GeKAsW2kpIg7xvJ?=
 =?us-ascii?Q?+j/4C2eycRMJpjFHWNYBiYoRvUFFjz5Wa6mxrquBdgz5BVXJYRP74h7aedoP?=
 =?us-ascii?Q?KPUL8jRxstF4qyfhPHhT/AIeb/aPlnARYDEZrO0ViaUg6QlVRYBKZUi6Khv/?=
 =?us-ascii?Q?Kh7pVZu+4i54ApzSCowEGpA5maoweEchVKJfDli/WliWuBdfrZX0W7aS1NYh?=
 =?us-ascii?Q?bTPH1rnMd6oqDj9BJJVuUm0tS8tIJh21Lj1SKZsVbYqUPQwFf7fwwGwH3Qhn?=
 =?us-ascii?Q?rSGpRpuIHtv9QxDg7x1G1dmw382SxZJeQMp/6Usg0xFyHfe6gq2/ae77kcbv?=
 =?us-ascii?Q?+1ocJt9HGxxCCOuO6Iab1Rd9xHIOAkuCwSsP9vNByxTK6/d/Q2cxcq7RzXXw?=
 =?us-ascii?Q?rMcZuOrECm8JSns5MR9NKsHKldfuuVK+t3PCHGwnqBt329BTu6E0L/A7vg1c?=
 =?us-ascii?Q?E6plZBIRY87s48B/1ubJ31/rcN7tQLakuIp17Pzs7b0ScFEiPBIE9BKGsZZf?=
 =?us-ascii?Q?Xv7xERcffnsTjsMlSvb/MWmm6+O4rCIjLF0TyJMBzTSv6GesACAYB1bUn+V1?=
 =?us-ascii?Q?UP1KkIpZBzzAE/E1oj8yCuH1ZYVL7fb7wlzIt7/oDBJlmgpv1EYMd305ydJ2?=
 =?us-ascii?Q?JkZPW2RoA4Hn88T+mTk4Pdt9hvlKvUB+5cs8b0kjhhRLlJ8NOhN3SMw2+3l9?=
 =?us-ascii?Q?Q9EdvmqUVDn/nySziEk1wRTvHcp6YzswlpXhpakhSiXK6Ml175o3Ny/rzxdQ?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00696147A41C5040B36486EF2988490F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xFeR7LfkudS/JYtoonIEh/Jei+mYvrAMbElBFkQ0Ujgt1206gdD1RuCboZQF?=
 =?us-ascii?Q?njTG6WDL3WfHLNfEd1MYJsit1Y+OyXjq9OhF85xQpBjrtSlEB2GtOtcl01Jp?=
 =?us-ascii?Q?x0nEGORJIxDKOQQaacaMDVgSnAb/r8S2G1k8Bx9E1SiZkk39xvrfWehUBOSs?=
 =?us-ascii?Q?5eUG3vICutr0K+XJp/Ij+G//jKvUdzPOYDIsootUaOveZrDx8E6KQE1Zpj8p?=
 =?us-ascii?Q?D0fuVV3uOUyAbUrLDwwKDrRK+9jfHW37pLnM4FYVSdmNb0zgfdkyObwpy/fq?=
 =?us-ascii?Q?jcC75vovwM5PkMQjogqDLrOa4ieJHvWFBecMtOD7iVGOiSpBsZ4O4Xp9dSPG?=
 =?us-ascii?Q?lU2NMqf8ng0nB7EUZ9b9+dED78EFPbele7QIRsrrA7BDRj9Gh04gyj4mvS/C?=
 =?us-ascii?Q?9OITXnP8fewI02DDVlEO2ehXX1jiIVh13Z1tmwq68yiE7tGy1TLouqeAkPnb?=
 =?us-ascii?Q?0UplKS7ixHep11nGhPm/rG77rGuzFU1f9X73FCcEy1sI+alWvmYS1PXbSUf3?=
 =?us-ascii?Q?l4Q4eVNBLyeFRm/fg/+U1gPdDmT7fOZBLSRE1eWT/ew6wwlmflDwMzLRpXVO?=
 =?us-ascii?Q?7pM6ty2kTOQzVUxln/8n5KlaLQ3SZpeaSVrn55/SdKnO+tK4WqQCwuP/YBi5?=
 =?us-ascii?Q?SCPKbF2MGf/dtB4oB7pRCn2YFQdE1o5o43uP4QNPWPe0YJJXo11U7RtkHmIh?=
 =?us-ascii?Q?N5X9OHkSWr7s7B5XjA0FWheXd0gqfUzo5eXmjVoMJlDFbMCy+PaOtmyo/6Sc?=
 =?us-ascii?Q?yZFsQLl7oQ9NCK113nxdRiG8esNJ4m1ZQqw+Di5jdp7F5UhIdb3vW5227icb?=
 =?us-ascii?Q?gdoGGctkcsjTDnmoxjtPG3WCq0BT8/s/30G8aNW6ew6MoHx4x6kHdRmLwv82?=
 =?us-ascii?Q?2eRxVDds6eD6/LRnDfa7HjLA7xjSUxfrqtaK190f2RZYtScx4gKs0g8Fo0S5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563388f0-d933-4279-9549-08db7d9f11fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 21:30:35.7843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gvJJ8LP4mdtEVTYTIqG/ieOkZRw7QqH9dFat58NkFUzpcgDuwm7R+QRHpu8AN6l2YkRaIDKkA4rA3zShv/jS0plIzMg3p3bqrLAx/va/Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=941 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050195
X-Proofpoint-GUID: SiE2QgXJubKxj0jQkg-XJs0r81vD0Ffw
X-Proofpoint-ORIG-GUID: SiE2QgXJubKxj0jQkg-XJs0r81vD0Ffw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Jul 4, 2023, at 6:30 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> Please update the "case Opt_appraise_flag:" and remove "appraise_flag=3D"
> in the powerpc arch specific policy rules.

I will make both changes in V2, thanks.

