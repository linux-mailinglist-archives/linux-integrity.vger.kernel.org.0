Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDAB4040FC
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Sep 2021 00:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhIHW1f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Sep 2021 18:27:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32572 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229997AbhIHW1e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Sep 2021 18:27:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LdPhR016612;
        Wed, 8 Sep 2021 22:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2021-07-09;
 bh=DfQhmDps2NVOdSPnf06TRf/jdZEIP2ANDajt4oPLiN4=;
 b=m1CibomPotI+W4H8EGNpS4zwuGspordUYrKFvKcrISaDUkXYQy5DGfbfh+BXNYKvU5um
 YcbCTT9AfHi87YVYC2OxIrIUfdOPMEZiSEcbaPpfaue+dy6kZkZBpv+AsKQM/FjRvv+q
 9cJxEDTR/DjwAvbT9muSVEeHaOkxlGNL2OUrpug7w5ZX1bkf+qDCOFh/Ix0Cub+EnUHp
 RkVBSoT56XKUmnF7VRaERXZdoTkYidkFVefzZw1SdtwB/ub5SmGITNL2/YiDBLhoiLQx
 /bogTAMAnLBhTKyjPzygGB8x+d0U6NouvgedyoHYZ4b9iWweInvTmN+S+zLiTa5PiHM8 RA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=DfQhmDps2NVOdSPnf06TRf/jdZEIP2ANDajt4oPLiN4=;
 b=Iy4d4ojjCkKWlnK2ww00kvtC+/yyEOiBCdmNK/OTyNI1C3eZJ+CjxLynmyTN8A+VmKfh
 fQea/6xhJtUF3euJWwiVv7/FEibMGtxOHg8EJKenaqvp5VxMH8/tJqxxPx9OA6b6xN+h
 ilY8/d7Ir5fhe3yl1tiIOSCoApdHiencqUiQDUdB1y1M/IvbPcAsjS5KJbs8XKrVqnPS
 SarSYLTb8HqvKDkXcIeR+aaL0e/t3cUWqAoegNBRtALW44pfGfEkK3o9VzjkTjbMczog
 rY7T+OTJG29SmBQTC8qXfIgoxKCL2kftw1NU3jpFc7cdHX2wvAMoJSOI3/TsM3B/mG3k wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd7tca31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 22:25:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188MGENP066355;
        Wed, 8 Sep 2021 22:25:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by aserp3030.oracle.com with ESMTP id 3axcppcbj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 22:25:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASjXTzjcmk0fCB/YX2+Cd5cvD5wZ66LGNr6helJp1EE1ySe8Ws9dpKXigCjmiJeIMcYyQbx2S6tdElondS5HK3JDmo7cNbBwLIl3mxsCxxS0AW6bFyShIG3Z/Mdm/+JGjaiBmcfXa7hFTijEur2eor6tzUVAvrCPEWsNk5a+SsyVkdP4FlkwZCWapxhqL+AzUCDs1xXZUz3vBx2efAYJV5E+9ia5/zC1yPTTsK5MeiyiOnI4akbNWPA9bLux4CVDH7giT+GUQQPCOt8X7jl7ZOJdh5gMwuP304BTVVrb5Dr+kvSA/1IZVaMK9DvBC2NgDRzojQial0oGCZywfqfeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=DfQhmDps2NVOdSPnf06TRf/jdZEIP2ANDajt4oPLiN4=;
 b=J9nnP50krWemES1OmSN7KLyIsq1y40lf8oecDGSdOXbmhQAjw0sPuFS3f0KSMRSZzu+FP4wunMSJXJSkMvy5DhUTUYl0WmqZ4no0zdlThe4YuiWXeLFRXX5DkMCqtXcdgWeIti/6tMDImzjZ22y5ULBMAN8RI4MIvubQc22554IdMLr5HsNaK3UcX2oeYE/xHXhvcbQz7badRrSE+xi8UjCDqkQmeRBX96b2hVb7a//1Ha9EqVhTe5dCEgS4ffpmgFjgidceqgSkV36qiW3u+lF0bxaESIEGgAGbXaYN524boWaYlTUVpsZdbaoWtwoCNBlJHulDP6t+4Hbe+BNBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DfQhmDps2NVOdSPnf06TRf/jdZEIP2ANDajt4oPLiN4=;
 b=OeW+iOCMHgsIuhabmPQhMjA54cWW0cCocCdaNdNRNhYbrf5fvuQsp2cdE7I+1ryKpxshNsJ4IHS4yqNU7ED5wuNTwa8FaCtMMMy+QXbdcpqFizCDYc0C4Dsqi0uU/AXtZ2EjIH+kQ9eh7FHbUSZd8/YuMp68b/qMfSkJkpLo19E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4940.namprd10.prod.outlook.com (2603:10b6:610:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 22:25:45 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::340c:c4d9:1efa:5bc7%8]) with mapi id 15.20.4500.016; Wed, 8 Sep 2021
 22:25:45 +0000
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v5 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <b44726f2d71960d53b4860ccab71f02186295da9.camel@kernel.org>
Date:   Wed, 8 Sep 2021 16:25:35 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>, keescook@chromium.org,
        gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
        scott.branden@broadcom.com, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        lszubowi@redhat.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        pjones@redhat.com,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3685CAB2-43EB-47BA-80E8-C830D3339458@oracle.com>
References: <20210907160110.2699645-1-eric.snowberg@oracle.com>
 <7f9fb65a4ee20c337646a1fc887cd24365c2c59e.camel@kernel.org>
 <b44726f2d71960d53b4860ccab71f02186295da9.camel@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SN7PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:806:126::21) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
Received: from [IPv6:2606:b400:2001:93:8000::53] (2606:b400:8024:1010::17c6) by SN7PR04CA0196.namprd04.prod.outlook.com (2603:10b6:806:126::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 22:25:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3613c560-61c6-4fca-ea99-08d9731799ad
X-MS-TrafficTypeDiagnostic: CH0PR10MB4940:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB494078EBF585909E49E558CA87D49@CH0PR10MB4940.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+wwH5fpDSzl6c+kb46KIfhg/SrNIOXiyEw9OXVij2lqNtCJFdcEp4hiRXQhgds5hq/mJQtY1AMkFjbK45bU2dAbTuy1a43XfH+ykazO4U63TdopktxMfYl74Wg4HmdhcF9+SoaBnKn0FGaxiCjGK6FKOygXs6rlMRb4YmC273KDIpjJNqnYamPuArT6pmApfTI9Rb4q9cJrLYY9wovYmDc7PVddgepVWL9R0cl9c92NE2klCGQEyxFaXrSWCApHG8EE5pl7R1XSQBSIXX3GCRAxGviYdlOsoyjLlbLEjWH0CPEsdrwdKQZ1rG9L/SymXQ0iJc4/bDwGJZ1EoxvnBMhosw4nJ/5kHR0CmUr3TOrhohaH4UswJIZiHDSfO0BhvBOxaIBRopt3BA5ZZRnyMeksxwR98WNWostQJgV7X4KoCOF21/fzQdwZ9ABvP+Ib/S+wtuzzWNmDKaIuVlSLwkTGTSBzOdXmYdtuGJqlo5WK2JlyZz+qzXF0bSNfDB0+qI0WViXTjysfA56ZLuCQ/d7B2v3NniKSVCmLajwDSE/ZqDTWQHEOmgdmdTgqpt/6QTV1qrAmXAFP3AkPZcFrnliVjd7yzXF4bwRNwb8VmMkieP36KW4vxh7+fAXjk5BtAdQYIFj7ENa7mKxP1NslmR/P3UJMfz4pOm0+1oTzmpLtjVEoEwNJlOjicIKyS47VWlDau5JK8jejhh1xtpvPJYhbr6J92H2YhmgbcZn2YoDRWy/k0fST+R4iKl3we5mUwMyeYKsILa1emQP+5Lvxi8Bha44S6mNTN1V8TWNRFm3tr+R4Jse3l5RdKqqFH5Fv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(376002)(366004)(39860400002)(2906002)(52116002)(53546011)(966005)(8676002)(4326008)(44832011)(66476007)(6666004)(2616005)(107886003)(66556008)(5660300002)(6486002)(83380400001)(38100700002)(186003)(6916009)(86362001)(54906003)(7416002)(478600001)(66946007)(33656002)(36756003)(8936002)(316002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHoxMTRFMGVnUXdubzNzSHJBOUNDRUpUU21KY0V5VzNYME5FN3BkNENrUGJI?=
 =?utf-8?B?bTh3YnZheS8rcGhhMmxMS0JRalRCRElJckE2L3B1YXpyK2pFQ3RRbDk5ekt5?=
 =?utf-8?B?T0FiZVNVSDhCTjFaM3kyNTZlRzRpUDBoRTd3MzB2SVVOMDAzVGM5cmhjYXVi?=
 =?utf-8?B?ZGV6NUZtWmFOSDlvSk9aNU9DTlJXRjIxTFgxQ3dVY3BwaTJyYnIrRjVuVnJk?=
 =?utf-8?B?VkV3WlloOFNFTTRUMTFkS1VlL2piYXBEMGF2QW1OZmVWQmM4YnhqWFNmbTVm?=
 =?utf-8?B?cGhuSUZRTWpKTzdxa1h1WVowSDFsL1dmcEZSNy9lV0hwUTFURTVOejlEdGpV?=
 =?utf-8?B?RFpXc3ZYajF2MGhEMW55ZktpZnZjWHFQUTA0VGdFbFFKakRjNFN3aFk2bU1I?=
 =?utf-8?B?K24zazVYaVZ6dGdoQnF2bXkxZk0xS3V4cFZQU3lJeWpEK2hMOHBIRko3eU5J?=
 =?utf-8?B?VEhYVW9lRkU1akNlT2wxM2p3NGNTYkhXdVpJaXJmUXFYQ0FLL2xFQ01NWmcv?=
 =?utf-8?B?cmtOeDFuZ044NVVXMkRiWjk5L0h2VzVoWWFQN3psaHJlazluRVRzSEZaRVYz?=
 =?utf-8?B?SXF5NUs4YnJxclZ6OWNVdmFJdlUxdFA5MjZGMldWMndxdmpKNTZvckxWd0lI?=
 =?utf-8?B?cTJzSXBIQkFQRS91TTJFQmVqZFBzdGZCdk9aVytpbG1ubG01M3B6bTVVZ1F5?=
 =?utf-8?B?Smwvenk3YmpCWVFFanFCSWdaMG0raGx1L0tRdTRoTW9jTW04ZGhBUmRvdy9J?=
 =?utf-8?B?TEprMkhqVEwwaE93WjlBS0NRZ29LNjVOQ3UraGRaQkFUbjJkaEx1a1c0Y2Rx?=
 =?utf-8?B?Vmd4NkxyMTJBOTdsTTk0YkJzaGkxMVhQNTdpaVBHNlo2TjM2a0t2R1Jsb29F?=
 =?utf-8?B?Y0ExQ3ZDalhFQkx4eE1maVE1R3Fpa0dqb0t2UWJ3ckZoeXZ3WndSN1MyUmlp?=
 =?utf-8?B?MVdMVVVsVTA5d1VkdDZId2VIMlJ3SGdmTUhTWmtad0Qyc0lEQXhYVlMxTGV1?=
 =?utf-8?B?bXFCVE1ISFVFZ0lIUnZkbndEUkVzMmREK3pXSC9WOGJzdmlQY1d0UTNvNjI5?=
 =?utf-8?B?MkdjZVBxOXJBTlhJeDN0L2NtOTZkL3JzK2JnenJWMVNOMUZlbnFiUHErVTFT?=
 =?utf-8?B?UDZIc0NWejVrd0hZYlhHMFVYVkhUTXZMN01wSnRMTDZPR1lidlAvamxLbGxo?=
 =?utf-8?B?Q1pOWERkOHNkaGRqWi85Y0ZoeFprbklFSEsydytnb2xveFBQelBTVkVWcDAw?=
 =?utf-8?B?STFQNlMzVXNTRU5Yai9FNDh6dW1hVUxEQnFZMHhWUlE0T2w0a3RacFMxSm45?=
 =?utf-8?B?VStwVGllMzhmeCtUTk1sZGtVL2ZtNEVlYnRqb0JEd29jK05XRC9Jc1ZpZXBX?=
 =?utf-8?B?dk9QSUVqQzJWWDdoRlBJQjMyT3NQcSsvSTZZZC9XM2prS0t2ZXdXclArSW9p?=
 =?utf-8?B?KzZuaTlKNGUxSnI4L1d1RGhxZXo1UThOS2xXTlNzaFFkdWVhdXZ3QW82aUQ4?=
 =?utf-8?B?elJScklDNk1iYnk4dHAxZitSTTFUNTR1NHhGZkpyVC9NTEttclZBU2JEZ0k3?=
 =?utf-8?B?QUswb2ozUkpuNkRNQ1hnbzNZc2ZpSmU4b2ZncG1sQ2NrbUtWMDBMcXg2WjJB?=
 =?utf-8?B?NHFMNG5BT2wzdkJiR01mUWNlWWNEQVZIcG5iQ01NcnVjOGhXeGtjQ2JtUVNJ?=
 =?utf-8?B?azlCRGtndUFHcTJVVmVFVXh3YWlib2ErTHVVekE3UjdVbitObUpsNUQ0NkR0?=
 =?utf-8?B?UlRSR2JESmVabHJVYXNtRFFrMVFHSnFzeGxLSHJxZGdvWVIvck05a0dZY21t?=
 =?utf-8?B?ZXZrMkVSZmdLWVByeTRnQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3613c560-61c6-4fca-ea99-08d9731799ad
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 22:25:45.2127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27fT6Tg8U2jOpUBnfA9cLnRFaPz7984kNo+6NqWYeFXPieULgED1195ABjCPV2Sc5Do/MOrJxjiHzESIusT3bsMRwMqpXs1G/0Xc8YxVrE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4940
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080139
X-Proofpoint-GUID: 8ElGwrMEi2S275LorEhrnsdSt82ypDhU
X-Proofpoint-ORIG-GUID: 8ElGwrMEi2S275LorEhrnsdSt82ypDhU
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Sep 8, 2021, at 10:49 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Wed, 2021-09-08 at 19:03 +0300, Jarkko Sakkinen wrote:
>>=20
>>> Downstream Linux distros try to have a single signed kernel for each
>>> architecture.  Each end-user may use this kernel in entirely different
>>> ways.  Some downstream kernels have chosen to always trust platform key=
s
>>> within the Linux trust boundary for kernel module signing.  These
>>> kernels have no way of using digital signature base IMA appraisal.
>>>=20
>>> This series introduces a new Linux kernel keyring containing the Machin=
e
>>> Owner Keys (MOK) called .machine. It also adds a new MOK variable to sh=
im.
>>> This variable allows the end-user to decide if they want to trust keys
>>> enrolled in the MOK within the Linux trust boundary.  By default,
>>> nothing changes; MOK keys are not trusted within the Linux kernel.  The=
y
>>> are only trusted after the end-user makes the decision themselves.  The
>>> end-user would set this through mokutil using a new --trust-mok option
>>> [3]. This would work similar to how the kernel uses MOK variables to
>>> enable/disable signature validation as well as use/ignore the db.
>>=20
>> OK, changes are described here (again speaking about trusting tho). The
>> motivation part is missing. The text before this is more like confusion
>> part. When you describe motivation to do something you should really be =
in
>> grass roots, e.g. "when you have this feature in the kernel, look, I can
>> do now this". It's not that hard. E.g. with an usage example it is quite
>> quick accomplish this.
>=20
> The code changes overally make sense but this motivotional part is the
> problem. E.g. if you do a pull request, it is completely *unusable* in
> that context. In that case I would have to write something that should
> have been the cover letter. It's 12 patches, so it is perfectly sensible
> to ask a better one.

Would this be a more appropriate cover letter that includes a better
motivation?

Back in 2013 Linus requested a feature to allow end-users to have the=20
ability "to add their own keys and sign modules they trust".  This was his=
=20
*second* order outlined here [1].  There have been many attempts over the
years to solve this problem, all have been rejected.  Many distributions=20
carry one of these rejected attempts. This series tries to solve this probl=
em=20
with a solution that takes into account all the problems brought up in the=
=20
previous attempts.

This series introduces a new Linux kernel keyring containing the Machine
Owner Keys (MOK) called .machine. It also adds a new MOK variable to shim.
This variable allows the end-user to decide if they want to load keys
enrolled in the MOK within the Linux kernel.  By default, nothing changes;=
=20
MOK keys are not loaded within the Linux kernel.  They are only loaded afte=
r
the end-user makes the decision themselves.  The end-user would set this=20
through mokutil using a new --trust-mok option [2]. This would work similar=
=20
to how the kernel uses MOK variables to enable/disable signature validation=
=20
as well as use/ignore the db. Mimi has suggested that only CA keys be loade=
d=20
into this keyring. All other certs will load into the platform keyring inst=
ead.

Secure Boot keys will never be loaded.  They will always be loaded into
the platform keyring.  If an end-user wanted to load one, they would
need to enroll it into the MOK.

Steps required by the end user:

Sign kernel module with user created key:
$ /usr/src/kernels/$(uname -r)/scripts/sign-file sha512 signing_key.priv \
    signing_key.x509 my_module.ko

Import the key into the MOK
$ mokutil --import signing_key.x509

Setup the kernel to load MOK keys into the .machine keyring
$ mokutil =E2=80=94trust-mok

Then reboot, the MokManager will load and ask if you want to trust the MOK=
=20
key and enroll the MOK into the MOKList.  Afterwards the signed kernel modu=
le=20
will load.

I have included links to both the mokutil [2] and shim [3] changes I
have made to support this new functionality.

[1] https://marc.info/?l=3Dlinux-kernel&m=3D136185386310140&w=3D2
[2] https://github.com/esnowberg/mokutil/tree/0.3.0-mokvars-v2
[3] https://github.com/esnowberg/shim/tree/mokvars-v2=
