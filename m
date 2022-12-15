Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B103564DE9A
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Dec 2022 17:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiLOQ2e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Dec 2022 11:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiLOQ2H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Dec 2022 11:28:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EE8233A3;
        Thu, 15 Dec 2022 08:27:42 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BFEn06G029485;
        Thu, 15 Dec 2022 16:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3pORO6Ini2JfF1+KK0ECpT2JLIjQXpib6zxF5s6xM/E=;
 b=Qp3asQx21FNvK9th1hS+wf9ENUzavN2RJrmTYBVoZDtZIDgWWx40GZQDZzcSGujMRw9H
 I1MfxOxybHvrqZzraGQ7aEyFEFtpclqGeBiTzfYC1dd/G7SNRL+oSyZg0ZYn9aWYrTPe
 +3vJkK9IYVt7WwS/aCn/SNE13cc6zXwT82krAF5ipO3FWeaak7jA8dt7ps3p69cXnlmC
 DKqy2RZZgYmz/dRt5MRjq9gv6/gpDSOv1p6I8t53bq+0gwJci3o9Ol5tXZoCYSPwHat2
 X0jv+QXU5z6dLY28H6BgeqX8B28MK34CzFgmU1tSSNzer4x9uUFsNxhAj3qWSTNpOHNC 8Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3meyeu5m16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 16:26:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BFG3gdQ032949;
        Thu, 15 Dec 2022 16:26:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3meyeqxrkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Dec 2022 16:26:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2Wa3n4JNgOwGV10xWTGLiDAdDuOIMVK4Q3zyFmZ+3rYqn/B7u5co4AFJUOfN2KJyqhkTxP5kHVY/FXv5XV3f6ijkgM8FgXG34RjiUhG8f6u4SN/IptNgd8j45YuaWJT5ByORsGAClglMHAUHzRdXj+uGCZ+te7jiOgcoi8fnzvclAKthKbg8GmlObXUXgBXdriDUYanTxfZJC6mMkytSPh4sHzzsghYjqrz+MZ37Tte28X8H4t0c0+p4djFObeO2yxLn6p61lntmF9rSNKE8Gbb5r7EhMtEVmorK/yW4kPh3wGMJHtMSWUm5CqxYoZcZJ8A3UNrqvqhMQv3vHiT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pORO6Ini2JfF1+KK0ECpT2JLIjQXpib6zxF5s6xM/E=;
 b=OSKaenAwUfo4cENEyaqXNYG5URSpSmn5xg/g+lCyNsdBGqVLIN3GKmO1FEHBXEov6LBmDMASmGaINDmgNhNRd6RS4K3gLGWCdB6D3eQxesp1uwQ5byse7Uv4i/pECZEWBgrFj5N1uQHylQtSb21pqVNOlds4yqWpmXdFHCYgftF9vtuC8l3MV4W/9Bg7Ghz4a5pFDx/8KBgMLNAwnlZ59a7u5plfrCWkAsbJZwBM+HlR7/Fr1HUs+V9yKi45EABoo1AXClkX1za0YBtiG0MeC623zCjAiFM2TIZbqGmK4/OU+QTewNCr3eQEr03GJFgNEJytmnPRlCJCh/nS61rGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pORO6Ini2JfF1+KK0ECpT2JLIjQXpib6zxF5s6xM/E=;
 b=MOwt3j6xKZRSbjKdIrGIkTq5eaCmAwVpr4+hRCwGXQqQGpcjO3HboeyLLo8XQ5BSrJwFc6jwm0JvI0XTpY0+OEJ7fpgalh9Mo8nLmJ3egAPshMO0x4krMaI0jFZDhw6zrZ4AZCQgJtAKC3kdLKT4sCbx09No2ovSX2qlzpT+6Xs=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 16:26:54 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::f006:f411:9056:63a4%4]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 16:26:54 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "pvorel@suse.cz" <pvorel@suse.cz>,
        "noodles@fb.com" <noodles@fb.com>, "tiwai@suse.de" <tiwai@suse.de>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Elaine Palmer <erpalmer@linux.vnet.ibm.com>,
        Coiby Xu <coxu@redhat.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Topic: [PATCH v3 00/10] Add CA enforcement keyring restrictions
Thread-Index: AQHZD1PCFegbrli1zUCp/3TmJTzIr65uvzMAgABmOoA=
Date:   Thu, 15 Dec 2022 16:26:53 +0000
Message-ID: <4CE6F17D-9D87-4024-9E1A-FDFE7C29D5FC@oracle.com>
References: <20221214003401.4086781-1-eric.snowberg@oracle.com>
 <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
In-Reply-To: <b8e54d077da633132eb6da03ea536face095a425.camel@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ0PR10MB4413:EE_
x-ms-office365-filtering-correlation-id: 4f297545-7306-4808-3652-08dadeb92d83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Am6hpmwbQx9VlqJXGL1QyDgbXnWvw9Icys/AfxaNPqTqmSz5iWHEGZC6KmrG1QONnS4QMPE+xwP546pjConDSnbokofuWs9iPW6LrTfsMPWWXHbKSwqnA0FySLcdK+HNIYIStrawXe+O3piUE2+RMiH0tb6HI7DMwTRu0WlPOFf50nc8qz16Ss5d80wdExYbvfr0iR4g/Ixl6ZDwIWEJZKYXLUqgX14zKDt8GMCNsRzMH5P57KIZJOE4I4LSeib6IcSqhXEaX9N5lYRht5ScOFOv1PktAsI3Ea4Qb+mCKj2ihjGdE+i0dTLmseKdMcNXvS+LjtlvTYsBamHr6yjHf9455sHSsLfleClCiPC7UzHjOAqwzyPDr7OW88+tVsPUOyQLQsICkdnDNtByaK6KUNz0uTm78s0Dxxu7DGCwQ6H6Jo0OfuaquKkl9PziW/OzTquCxqpYiO5VhVHQ6o4vuttHlgWke+EkyWrf0GUGcX7l6Eiohn6y7TGvQoijJ2hkZSpQ6Wj4eSt6mmp/3UdqRnhL9zMuXl4lF/Iey2kNu5KPT1ckSvqmO5iyO9h2pC+9hWzPCrh54WB3eYK/ucUp/+NWFbT1a5G8JmJOk3UJtLoQ2vW9sMUCdCGAAbJXZVsBAzENdNi1fWtFqBt/V5PTeqjEaE6+JytpcEQimWHYeb08cSl6+RmNWHmm3KtwFpyCfIzHYodZ0wcvqosgORfoYmNypB0G28Y49iVTVETprnk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199015)(36756003)(33656002)(8936002)(41300700001)(71200400001)(86362001)(6486002)(38100700002)(122000001)(91956017)(478600001)(2616005)(5660300002)(44832011)(53546011)(38070700005)(66946007)(66446008)(8676002)(186003)(76116006)(6916009)(64756008)(6506007)(7416002)(66556008)(4326008)(4001150100001)(26005)(66476007)(6512007)(83380400001)(316002)(2906002)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NFH2v3NpvLqRMIPpH3+Tlw+UKY757rFzRB1TnzZNbxpHAQY9i1VlD6y7xL5j?=
 =?us-ascii?Q?P5Z9yAI5U1VKYCkJSZ62SQIc+CO4RW5vrbQ69tua6rC9a+MyhY2wAxH8LpSh?=
 =?us-ascii?Q?Pg3VNUN8aianW1eogNtYXH9kApjSITePMcMjC3Hcm3o6ZOFE5aQgVB/+6YRH?=
 =?us-ascii?Q?qfFed/xwdSeaioMjaZ7PA5V2rg32XDwOcLRh/Fla+4ZqoqZTziVEvzIb3U4d?=
 =?us-ascii?Q?yG7h0HqRLzrhIpggWwN1KuAcw+Fm2nqvIZSXyrONaUSNQ7Uu7qWL3G35+FmQ?=
 =?us-ascii?Q?IstRcxde5nj1xnz0d92GnyfGovhh6pd2eqkURLRxBQzby6xPN/BZ5fHi6FnU?=
 =?us-ascii?Q?lfz7hgZ6p4zYLqha08ce1LTfM+EMSP/GyGzHKn9b5oT4+L7k9u2V3o7NbgMv?=
 =?us-ascii?Q?AM+7xmUKtJXlSBCto1KjZ0Ut2b9OJDyCvZz30njC+bh6d5tH9bw2Omg6NSgA?=
 =?us-ascii?Q?cauiqLbeo/nlVlvNfOwsqxUhO+FTn1Z8y9m8r9UgBupTc5uAJYNGEqLWA73v?=
 =?us-ascii?Q?T/A8qMap31SJI2/ENpY4Qn4oNXCtiXzUJDGzLTO3FX/JAbRgMl8bfni5qhGB?=
 =?us-ascii?Q?Ehx/czY7LFznPylN95i0XEdVsGw5AkHXq9cbft0xTUpOtmF85aAwrTirPAzj?=
 =?us-ascii?Q?E/9jaMWf3dSDGmnDmaVzUssQwTRAAb0udNkT5nqdDD4s8XWFzYo5w1DZT2Gl?=
 =?us-ascii?Q?xzgds5ODfcWuX+AKO1V4Q46UeYbEyx6EVOQb8GkqZmDScgEw4+Ijjd/6vBsD?=
 =?us-ascii?Q?QXnb4qa+M34esWlQRcPf1ibWx1VQShwvK1gHxfx9uP33jaorp3A/HjM+rJFB?=
 =?us-ascii?Q?mm8NyOou3F4XeuxGJQlX0tyRqufFxcBAJKegK0XHFXtOJxH24NrGEj3YDkhb?=
 =?us-ascii?Q?NR8/A2u0u2B4nwrrPIs2nSlzLw4cDL+ny0Aq1w26PNBL8RLAiDEtqmfQpHvV?=
 =?us-ascii?Q?Ic0vSZeUYJFmnBaUX67k3M1FedzYtqMrAfc/7ro7AuTKlxgTmlVPJubtzM8K?=
 =?us-ascii?Q?cwfAoxEH7vknHTuO0JSe80yzLSvs2HeMd4tvImn5TT0f67ouQRjAZ+/+k6W3?=
 =?us-ascii?Q?AH6T5lYrBIrJ9bR0yXChVnqsfHZ/T/qAk0Aqva09ejAgGAmySM/OA4eMnqLJ?=
 =?us-ascii?Q?E18waO44NMWZ+jiQuiD5e3ZQMvyK5+IuSn6aP6SuTEYET39QUTocauR1Btgv?=
 =?us-ascii?Q?TtblhqCHwetMVdlwA9BAcCgfGTDClUFoMczALoiHKZWhy7xymIZ8igJGpthX?=
 =?us-ascii?Q?UkMmfrcWEi57/XyxuBvBimvis7tP3ilcx7b1dRWhNAO+EqwUz81iS/bg6Qat?=
 =?us-ascii?Q?ta5/rF/dTcSwm3keJ45wR/tNoclu2upZaI9g3SZyjnhPuvje10PdwBh7MSv4?=
 =?us-ascii?Q?G3LCrogCxmZdwnSi5QjaPlhnKLpNU/2GnDHJyEkKHh95jNvWoI6SpnozU/Er?=
 =?us-ascii?Q?wucrEVe5oCIgi6vlTFcROWY4lubtmkdm0toN1NTvj6yN2oWswmys5mYoT8a+?=
 =?us-ascii?Q?uPWgWrzZHuNgqiIqPSzkgMGHvPCm9lCRhK+4QP2MzNe0rqJ23wvfEPcGhMhK?=
 =?us-ascii?Q?nxDeHKB3q8H1kAjzUp+Mm94d0R/cf+299PlZgtEfTI7pdTkyB9u7ejVcHvp4?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEC500C11E18D546BC73634AAFF9D79B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f297545-7306-4808-3652-08dadeb92d83
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 16:26:53.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6MBPTox+vUbUU5S2DjYTOEvivLOA+STmcHfOuwvc9Q998T+ITWlvoihZtIO1YtDBf1TqcYXs7T3mLiJb+fQWRHR2qnThgS47fmS7ObWtLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-15_10,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212150135
X-Proofpoint-ORIG-GUID: FNCMvDVxQbE2IgGqKDKdPR_VJp5JO5-F
X-Proofpoint-GUID: FNCMvDVxQbE2IgGqKDKdPR_VJp5JO5-F
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Dec 15, 2022, at 3:21 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:
>=20
> On Tue, 2022-12-13 at 19:33 -0500, Eric Snowberg wrote:
>> Prior to the introduction of the machine keyring, most distros simply=20
>> allowed all keys contained within the platform keyring to be used
>> for both kernel and module verification.  This was done by an out of
>> tree patch.  Some distros took it even further and loaded all these keys
>> into the secondary trusted keyring.  This also allowed the system owner=
=20
>> to add their own key for IMA usage.
>>=20
>> Each distro contains similar documentation on how to sign kernel modules
>> and enroll the key into the MOK.  The process is fairly straightforward.
>> With the introduction of the machine keyring, the process remains
>> basically the same, without the need for any out of tree patches.
>>=20
>> The machine keyring allowed distros to eliminate the out of tree patches
>> for kernel module signing.  However, it falls short in allowing the end=
=20
>> user to add their own keys for IMA. Currently the machine keyring can no=
t=20
>> be used as another trust anchor for adding keys to the ima keyring, sinc=
e=20
>> CA enforcement does not currently exist.  This would expand the current=
=20
>> integrity gap. The IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=20
>> Kconfig states that keys may be added to the ima keyrings if the key is=
=20
>> validly signed by a CA cert in the system built-in or secondary trusted=
=20
>> keyring.  Currently there is not code that enforces the contents of a
>> CA cert. Any key in the builtin or secondary keyring can be used.=20
>>=20
>> To allow IMA to be enabled with the machine keyring, this series introdu=
ces
>> enforcement of key usage in the certificate. This series also applies
>> this enforcement across all kernel keyrings.
>>=20
>> The machine keyring shares  similarities with both the builtin and
>> secondary keyrings.  Similar to the builtin, no keys may be added to the
>> machine keyring following boot. The secondary keyring allows user
>> provided keys to be added following boot; however, a previously enrolled
>> kernel key must vouch for the key before it may be included. The system
>> owner may include their own keys into the machine keyring prior to boot.
>> If the end-user is not the system owner, they may not add their own keys
>> to the machine keyring. =20
>>=20
>> The machine keyring is only populated when Secure Boot is enabled.  A
>> system owner has the ability to control the entire Secure Boot keychain
>> (PK, KEK, DB, and DBX).  The system owner can also turn Secure Boot off.
>> With this control, they may use insert-sys-cert to include their own key=
=20
>> and re-sign their kernel and have it boot.  The system owner also has=20
>> control to include or exclude MOK keys. This series does not try to=20
>> interpret how a system owner has configured their machine.  If the syste=
m=20
>> owner has taken the steps to add their own MOK keys, they will be=20
>> included in the machine keyring and used for verification, exactly=20
>> the same way as keys contained in the builtin and secondary keyrings.
>> Since the system owner has the ability to add keys before booting to
>> either the machine or builtin keyrings, it is viewed as inconsequential=
=20
>> if the key originated from one or the other.
>>=20
>> This series introduces two different ways to configure the machine keyri=
ng.
>> By default, nothing changes and all MOK keys are loaded into it.  Whenev=
er
>> a CA cert is found within the machine, builtin, or secondary, a flag=20
>> indicating this is stored in the public key struct.  The other option is=
=20
>> if the new Kconfig INTEGRITY_CA_MACHINE_KEYRING is enabled, only CA cert=
s=20
>> will be loaded into the machine keyring. All remaining MOK keys will be=
=20
>> loaded into the platform keyring.
>>=20
>> A CA cert shall be defined as any X509 certificate that contains the=20
>> keyCertSign key usage and has the CA bit set to true.
>=20
> Hi Eric,
>=20
> Allowing CA certificates with the digitalSignature key usage flag
> enabled defeats the purpose of the new Kconfig.  Please update the
> above definition to exclude the digitalSignature key usage flag and
> modify the code accordingly.

Within v2, the request was made to allow Intermediate CA certificates to be=
=20
loaded directly.  The Intermediate CA referenced was the one used by kernel=
.org. =20
This Intermediate CA contains both digitalSignature and keyCertSign.  If th=
e code=20
is changed to exclude this certificate, now the root CA has to be loaded ag=
ain.  Is that=20
the intent?


