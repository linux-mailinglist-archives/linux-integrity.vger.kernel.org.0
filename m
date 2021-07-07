Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4121F3BEC0A
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhGGQ0x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 12:26:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:8166 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGQ0v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 12:26:51 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167GGKJT012547;
        Wed, 7 Jul 2021 16:23:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=WmpXJPFXw3ldEYuPz/jFYyQVUnRIARApmyQRRT/yJdg=;
 b=rle2ET/g+JWoYKaao1mC+UOkgwjjfwmwL8bWmRHjwAt7J7iRGZvewrDKo3nqcuq+jxur
 wGQeSNC8p6g1wqkCA55FssMSQ0ZDjs2UXWRWNwWDcV3oDkAZqRphnx+yDRKwwSEB3Us1
 9ulgJazYaSMBEkLk9tpil8YqJkHHXcfagbt1vEr4APJjX4O2tc8t31iEQZtlgNFy8J89
 p+E7euYYA0ScBVO39VzKt7RQM0b7sOrkNpHj0UHQokf4zkLaM5kjMjjwvPTLFsyyQywG
 sJO3eGvNBN0s8ueCihLxA/Ex/QBSg3cwILAQrwcArC3ab3OpxqMADKEkj+vzuQ92K7NS Sg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m2aacjf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 16:23:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167GGLZ3076817;
        Wed, 7 Jul 2021 16:23:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 39jfqavjfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 16:23:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxJoo6/M3XCYJk3n/XlGbyWJAJP+GRmV4zW/NfemmWGwqF73eofuAvvrKaeG2WBw/FbHYSyGxsutUpZKVWfs9ISB3tf+PAnTE5BmzdqLoCPTCwm8WZLngxuRS+zEwWrQgsNkWRg5TZFRcZOY+4PU/ds30sekMXapW023a/OSJIq9WnidGVfju4L7B3nFNNP42TjpJN1ItjGCiaoUqKDqcaytxz03RCgQJnwmQZ+aBdw/0Vz8HjmGofg6AQ7jIle3cSG1w4hb977jIuYIY59W+00njz6rBkSHz7GGEQRhL3AKir8YzB9DJrhQDos7xzhg8VK4CHawUAs5+2rwJI0KMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmpXJPFXw3ldEYuPz/jFYyQVUnRIARApmyQRRT/yJdg=;
 b=hg23EzVV8omjV2vX8gF//LP3tHT7pOzrNvNEuSAZ7yE529QgdD7gS/RU8nMfrFfcm3MNOVnilMXAgx/7YNcLD7n7nLPyNYYKWiIewgCOJtxC1mksKqGTSrCURvfzEKw8HeuQkNG7B8mpjRnSWCZOUkv81ZJPUuN+AHYgRr6GqvWxGAA7Iim28CQip4rLNPv7Yq4DKoJ3z1AaJjMtofhIoi36CAJdkB22vO6TNe9LOfX91o0iukbY/ax2PM/JRcjab5aDuvdEYmiJx3oW7A2xt0UuD4jDtbGmuE/Zhiar8jgAHwI2xl/SqRKZj5aYpfPrBuIT7o39C5cePiKeaXPtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmpXJPFXw3ldEYuPz/jFYyQVUnRIARApmyQRRT/yJdg=;
 b=gOKbMrHyahBgd7RI+jMyYSa/mUPVB9aIU7GYizSf07rGVf674i5CtfZZrCBrdntn1Lmb+9/g5dEoR+nAz4vxxA1i+gZiRS1V52OBPekTjZz2+F847dOWPzSZ9renZRtqKMZmydUvWPEaIg6uCULpyIZrLROkQ/AfPKTLgfvoqzk=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB5497.namprd10.prod.outlook.com (2603:10b6:610:ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 16:23:11 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 16:23:11 +0000
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <YOVNrhxCJpfTbpVq@infradead.org>
Date:   Wed, 7 Jul 2021 10:23:04 -0600
Cc:     keyrings@vger.kernel.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko@kernel.org, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, scott.branden@broadcom.com,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        glin@suse.com, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
Content-Transfer-Encoding: 7bit
Message-Id: <E4A6A4E2-F9CB-4996-965A-772B3CA15555@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <YOVNrhxCJpfTbpVq@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SJ0PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::32) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by SJ0PR13CA0237.namprd13.prod.outlook.com (2603:10b6:a03:2c1::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10 via Frontend Transport; Wed, 7 Jul 2021 16:23:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af97337d-f266-4e2b-5026-08d94163834c
X-MS-TrafficTypeDiagnostic: CH0PR10MB5497:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB5497A3356927D1F471EBA5B4871A9@CH0PR10MB5497.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:352;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xPY/lqs6mdFGu3NaIx/K6Rgwbam6Ux9JzDpsEFHoZcVXQApHQWQ09r9FFdXBxuLH/nG3aCUQ9oCFDWdVVB3oHwWrBdc+cZC/xZM0e9UpnbrfM1Ge4UKQYavyS0Q7wNDHYfnwW9zzodtwoaqe7HhcE4rDRGdmaH0TfpaBNFmAZ72M+OhVfXUlcXjn1hgB7Cr68D4De6ra6zfIpJhPuxVp3uXLlSC+awx/8EVs6zWBVRzeh9vb/TydKwzLK6pdetTihB+OQtCoVE5qazhNsrURGyLYpl/GwuJQdce6gGBdrjT7CAKoWbHeDp/7KxsfeQBoAGqwzq3LXesIDbrKyJnAP3bHoD3IBTDG/SnXpe3d2+5KrS9HzuCfCASN2vKJsfQXMjTXs3gcfhgKtlQ+dmkumoztV63RLEzSyh2sUOav2/SRSP4bjplIvs5sR6liG12Sab4DuqETtGna5cUmcZVqxSv+QNBO1OXB/epya2HGB0QTCR5Po49vSCKFipXXxDZEPgnZOmvd4LFJrmpZbfqiAbSc02wX6FsINA0uF0q0Rv2jGTfAU/piEED0RVj7Gd43pVwNKvrY0l97AUGCl9MHhY59Su09Sj3IfMJbkoh7a/yQ+Y74Xd3PlGguEkoLBKqdiJ89yZu4AZxv+362/TLI+CtcSpev+s33PyNL4iPDVBUWgmodHgo1ULN6vV6S4TnMNuPvdMLP+/6GUhIaS1EiFeqEQKh8g2kYNqXsJkrquw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(478600001)(54906003)(16576012)(4326008)(4744005)(38350700002)(52116002)(33656002)(7416002)(956004)(36756003)(5660300002)(44832011)(316002)(2616005)(8676002)(107886003)(2906002)(186003)(6666004)(8936002)(6916009)(66556008)(86362001)(66476007)(53546011)(66946007)(83380400001)(6486002)(26005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2U/yv7QM0d0ZYPbid0IvjzXtRXaWRHjNTYEs/7yE/IYDI0WfUp6jYQpkTpE?=
 =?us-ascii?Q?eYEdviK/WKv1qKG6upigJUnGfbnfjINXsCCWxMcQzl1XwpKiVz0YIqtzHaJQ?=
 =?us-ascii?Q?K9q68MRtW4/o2uHnM7wVLgnWXZQ4kQj2NhYBgNVisG0NulB2+GEyP8w9OVkT?=
 =?us-ascii?Q?p/jAB326J3cHyZxVZELpLtodw4+P/HLip+/zapjlHscIsdNrhbUSHxrQS0Dy?=
 =?us-ascii?Q?5B85WejJ7SI9umyxj6xPF6+zb5iqNeYTRBTN94Muymhci3YgFrlPsubM9MDG?=
 =?us-ascii?Q?tfLMeT2BqFv9DIcX2Ky/4gfWLq4GvIQontMqG4HkJQLJDs7j2Yao9dtSx9ho?=
 =?us-ascii?Q?xVlPOtP/JVoCUYWibp/7+BeVUcvDb9GpRBxJv/PUNzaQdBh7TYZkiQqFDk+s?=
 =?us-ascii?Q?ckU51tQRSrSv0c5zkJrasw09wVh92GXfcGosbyhQSSAwzuW/oC25ys2jJ4kH?=
 =?us-ascii?Q?Gy2FOGgZXmpX1JRjs9tlPpdfqJcVmbTAMLf1qEeoyz6Bz70woBU7h8fns/N/?=
 =?us-ascii?Q?IlV2CWVtoqCXqcfdz1w/NHVBwHdk79JyTAgHBDj1ToMERe+RIhkGk7GbrpI1?=
 =?us-ascii?Q?IHl1h2OXWWQJqt1U+/xmkTWoyFRydl5NQr0Z77TIYe+ZrJ/u90sUauPP+Rls?=
 =?us-ascii?Q?joSay6hOg0O4o/Ez69sV7HB77wTLq2AYajNdsbtyyzIwKQi0plC+5a5bvlPt?=
 =?us-ascii?Q?LDfkvVt1V44WFPLYtW4loTi5l+mw/40Tht6f1T140+bqeIlkEnODZZ4EEhJD?=
 =?us-ascii?Q?KmU/pgtZ/n95yaKZOfk1LOU6wWVqwUK8MzwxgBXoPdEsfbE5JTMxy56IXZG1?=
 =?us-ascii?Q?A1HdyjM4XshGdh933fSsXJOKeyz7YAK8CYYlfp+fUc3I7n5tj9H2xFh3ovkz?=
 =?us-ascii?Q?zzHuOJiB8hipj2H9Q1bKw//g+d/RhC9yECTu4ns67Fjlbp9jMq3sVPxxr4Of?=
 =?us-ascii?Q?Gdjff6hWK9cKeLnHlw90l9h/wc+1yxTxO7J/9/Cc/01eQX+APNxhNNkqsSX1?=
 =?us-ascii?Q?iarpkEfSNKP+ykkAJynz420GCep7tcsniOn8qZ0hdK3Cr9Vq1G+SuQDy1Ks1?=
 =?us-ascii?Q?ODUgYf5Y8F85iUQiWgpmRiJldgFFSTdk1oxhJfyOo4ZwbjknCney/ELygP1m?=
 =?us-ascii?Q?LHTp2PIyr9Slb/PFnAvshRfq5WOOmqWwEDdTZaOKBJt0l9gN0PnYv97jYOX4?=
 =?us-ascii?Q?pAAso/BQyAcmnSs9hZx6fNSdcm36XWPMNaipIWtT5G83KAO3zpWmAfzP8w3v?=
 =?us-ascii?Q?43X43zbpZKeE2ydSUqwcszp4FEJMsBDLPozVFUVBxpls5T7HSCBm9IiWUzrh?=
 =?us-ascii?Q?e4MiSnWeUqv7EVu5BOiD0k5+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af97337d-f266-4e2b-5026-08d94163834c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 16:23:11.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKzf0aYynzxZni5ZHI/FNpDb0fLe80r0mBPNcCLXhrzNMI/QR4RCweurWBrcdWSZ5X2DYgHEV7UEc8nInoKdZkeOmrWzSiRvmayh2klbuzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=716
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070095
X-Proofpoint-ORIG-GUID: r0BBDT5qT1uEzfWoUNe1kRJP1cdQ_pv4
X-Proofpoint-GUID: r0BBDT5qT1uEzfWoUNe1kRJP1cdQ_pv4
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jul 7, 2021, at 12:46 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Tue, Jul 06, 2021 at 10:43:51PM -0400, Eric Snowberg wrote:
>> This is a follow up to the "Add additional MOK vars" [1] series I 
>> previously sent.  This series incorporates the feedback given 
>> both publicly on the mailing list and privately from Mimi. This 
>> series just focuses on getting end-user keys into the kernel trust 
>> boundary.
> 
> WTF is MOK?

MOK stands for Machine Owner Key.   The MOK facility can be used to 
import keys that you use to sign your own development kernel build, 
so that it is able to boot with UEFI Secure Boot enabled. Many Linux 
distributions have implemented UEFI Secure Boot using these keys 
as well as the ones Secure Boot provides.  It allows the end-user 
a choice, instead of locking them into only being able to use keys 
their hardware manufacture provided, or forcing them to enroll keys 
through their BIOS.

