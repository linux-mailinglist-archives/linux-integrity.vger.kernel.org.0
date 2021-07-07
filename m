Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43993BEC82
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 18:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhGGQtG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 12:49:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12050 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGQtF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 12:49:05 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167GaY4a024839;
        Wed, 7 Jul 2021 16:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 subject : from : in-reply-to : date : cc : content-transfer-encoding :
 message-id : references : to : mime-version; s=corp-2020-01-29;
 bh=Yyx22g7PhnDRUSRYa10cpp0RESayAk4Iw8DCo1+anLg=;
 b=Vjm7xdNH89cRZUtit0U/b5qwnf5Xz/KAtEZ8DQNmSHVXs/HH6IlvIScdwN+kc88vs+H8
 xhCfafJK1RhzoikrVJFoCh/pdRWygWgSYrq6xMxemUArPlcI49yvPG9N6YFWjtbDMedA
 Mochdb7A3hTvNk/vVvDyn1sQn7/gZhAnmt2w/V7DWfkGuhGDOPuK1Yvyew9Uk5iJntlW
 nU1Lho0VGav8IgzXJWrsF4DNd1ErmrCoUSFnKDgfcxm/BYzwaPbssbmzq4RwdFaELP8A
 VEvRthJGzApWZj/rgIIUP6kS+W2zCYwG0vmJVtYJAwfUY/yED2/825pdPBcqAgSZBPPV 3w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39m3mhcjv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 16:45:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167GacUA150461;
        Wed, 7 Jul 2021 16:45:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by aserp3020.oracle.com with ESMTP id 39jfqawubn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 16:45:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXst52Zp9N4j6ZiYiLTQBdJ3ypuOn0QAdKQy8qyLv2arGDI+HZ+yBF/7m7/umzz3H4vHVZCMHFXqkkRDBMLvOjcRCkR+gGnYecK7gGJ81HQsO9RiGNWd8Erg52sue70iyCkZnSAel/9q4eo/qdvCGYDTUYexrO0ol6amTLZcwAPJrKXo3qDTvdvT3qr65IlzU7jDI/uImprs3W0bmzNKkJhm0E0ntiS1/P8soPtUFmGsYSSPM1QN0bFVEE1PirmSx7eRJh3FWUfuouHWnQvQNIAhNZKm5ayxIlTCLeMnT31Fg/v7RhhEv5dTFzlcyUruN9hvZCOXGgQ0TI+bxmAk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyx22g7PhnDRUSRYa10cpp0RESayAk4Iw8DCo1+anLg=;
 b=MWHcICrGy2tuMIZRmiRKXgMJETPJvODFdxBQQMKBav5Xgw7cEbrv/BWpu88kQ+ctSDvMutdfceqAz/LrqrJJ17nBmKlfXPjXp42p499P/083SYGUt2duIxmBeYHAd+LU/OM+1G1TcoQ4ro5f7ZOd9dC7gnTpqj2nPMreBAqTCNiYw/aJQNHsQYDTd/L9gYOqb7OdYxJ7b+jtLWQsuPcrR2wRc7q02F8oTrydiMBj6AA5gw52IteQPcTZVOaU9bZ9R5tljHrJm6ordffr1cn25AoMWpbTpvXkZ3W/tinulfHrS6DwCSgPOCBv9oD4SLHwOMpwhBddjnsMf1gRVCL9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyx22g7PhnDRUSRYa10cpp0RESayAk4Iw8DCo1+anLg=;
 b=sY5OvgH3Bgijih0wR0T3XjSAu4O2cy4F8ueTWH0sw7TytSW3FhM0DrQLuCPEtonbxE2hRFnc5ZDZ2NK7bpTxgTk6jkJh6s/rDHamCHK4cvrKvUGHI/5SRraVgGTV7cc1drQmdaSWunUJiSNkPByUXxa5oS+s10JQhNviSm17nzM=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by CH0PR10MB4940.namprd10.prod.outlook.com (2603:10b6:610:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 7 Jul
 2021 16:45:25 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::a890:e571:de3a:7197%8]) with mapi id 15.20.4287.027; Wed, 7 Jul 2021
 16:45:25 +0000
Content-Type: text/plain; charset=us-ascii
Subject: Re: [PATCH RFC 00/12] Enroll kernel keys thru MOK
From:   Eric Snowberg <eric.snowberg@oracle.com>
In-Reply-To: <YOXWOaPma2dMf6fk@infradead.org>
Date:   Wed, 7 Jul 2021 10:45:19 -0600
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
Message-Id: <5D5C7F22-7D45-4A79-864E-2BE710453282@oracle.com>
References: <20210707024403.1083977-1-eric.snowberg@oracle.com>
 <YOVNrhxCJpfTbpVq@infradead.org>
 <E4A6A4E2-F9CB-4996-965A-772B3CA15555@oracle.com>
 <YOXWOaPma2dMf6fk@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3273)
X-ClientProxiedBy: SJ0PR13CA0090.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::35) To CH2PR10MB4150.namprd10.prod.outlook.com
 (2603:10b6:610:ac::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.177.128] (184.60.195.210) by SJ0PR13CA0090.namprd13.prod.outlook.com (2603:10b6:a03:2c4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.10 via Frontend Transport; Wed, 7 Jul 2021 16:45:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0845e0e-f517-4f1a-75c1-08d941669e74
X-MS-TrafficTypeDiagnostic: CH0PR10MB4940:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR10MB4940158C98ED67FFFEA023D5871A9@CH0PR10MB4940.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh0bfhOeNsjDoWnTqfVuBt3OuiQSiX7AGJ4Yu4sGIZ/WbLDFKf+Ir9X2htYdY+K7DSsWdEZ2gispdX2PqqYmzZW0CqSmHCynxER6yeeD0k7B+iFP7bwoUa4fzZ5P1lJwDbMHaIVfyugX5cPvjrpZN6M07v+EMwkdxgBal6lRmSeVoDWxIc3+Naj9sy1ImiOwFWqco7L1YZTZwOUvXVvDdT63HFzMTmOi8kM2P9Wb1GQTYs1QLjuvknk9Jh7kaZ8ms7o6DRnGhdAc+c8j0ho9pmT2ltFey30UPbRayyRsSOylBCvYNPgH/eJOK+8CLonF+qhyaioyeGiyys0NWTfCuWUJK9YqVQpHReicdBAww2mgaPzgTVygv25q8JxcPYTTmNxQOIN+jqVZCcPEVoaPBOjxR8Ob0xYe6l7b4l+uplmoVgUdxj3S1NkTukOdH82j4k2JS3u2tpkjwtGSIzo4O78Ny+0gWUquSl7TwMxg5//CWjZuqmaZqthzNzJsShZYfkwIjmc9Tg8/ezfZO+Lht276Ws6LCzr27alhOl2LZKI2v9QXC/LktF+S6tenJTWpJBy9t5Ag9Y5GcP5Jl2D1wBP3KGTrwo24jK7RFPLITJqn/+HtYP7AMEn15EN6oekXhbVBLmq5DXGjETrwhh5cYSxJvilbQ/1AwuCk4/hE4R87YYryLP8Q1nV2sm90JqTklgxeaWDIgUmyDKgFqr6dTYDBscAnlY4eZaEdfjqx+BE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(26005)(2616005)(5660300002)(478600001)(53546011)(6916009)(316002)(6486002)(44832011)(66946007)(66556008)(16576012)(8936002)(86362001)(186003)(66476007)(956004)(83380400001)(36756003)(8676002)(52116002)(2906002)(54906003)(33656002)(38100700002)(38350700002)(107886003)(4326008)(6666004)(7416002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HDZ4ql/09EorCabXk3HOy7dk0d2k3NO7sgg9sUV2GOpytxOnR9LSmpd/4gNn?=
 =?us-ascii?Q?zk/MS/rExM+3SQImoirN18HR2aTy+evnD/AEel28IcFsRJLHksy9xnZtbfZY?=
 =?us-ascii?Q?2uAuP8jp9YCvtz+UgGB7F8vuX7DRUkuSrdsQjkYZRY91XXP6LhZDerj2oDv9?=
 =?us-ascii?Q?tHq6AGDVgqcBgAV56NYFkKZptDg5RnR6BQ6/B9803Jxv2x+wMuRvv5YovSuB?=
 =?us-ascii?Q?UPTH3A1NWrdS93hjBBJPYZpQMOy1SQK8EqoMPL+BTeWO7TbNT9tY/EI1Y1jF?=
 =?us-ascii?Q?zOLBFTgXtDiQ+KlIbDGOGms0sSbZ4HmJ6ESOKJ8ztD4KW0mS1gC9H5yngZTb?=
 =?us-ascii?Q?I8/0k4DU8LaCqFWfipCJDy/qBiRalcQukJR/YiSBArdEBkzMCovaPd/+bxYS?=
 =?us-ascii?Q?gQi0sE53S/hEgkW1AlROMyJ6Xo8TkF2YjOXJkmeX1RL3ksqZgOFJ3AwpwbiQ?=
 =?us-ascii?Q?8ubFHFYUP9HevAjo7lRzejtobLPptGI9skjD0Wzrua4aLuAZpn7oGGSGMSpG?=
 =?us-ascii?Q?GZs10e5IjhguQqy6hEzzaARfdA3sRjGscuFvw8B8vYOdfKrRu1FqmEjm0QAs?=
 =?us-ascii?Q?1MnpIaH8TxMfhG7Mr94CT+E7eCVKEg1yxLl3s6OH/i4tFZ2i/utbPCXXhQHA?=
 =?us-ascii?Q?+rNcWdirUOwp4RMWapUNsWKZGILAOvMBViiiEHAvmQDAMYWf8jeZP3TsjYpg?=
 =?us-ascii?Q?mrJbyGHxyEQa120njGKxVCuWsDxkD2EQ3wrZPYPDqlb6SNU6dCJAnyBsq2l5?=
 =?us-ascii?Q?vzCKpY5V75WvVr83TEXfKKFJATatkHjdgP9B6dslnbh99spI9fYLq1MrCZxw?=
 =?us-ascii?Q?8H7tD7Ly0QvlDYyuQzS1d0O3TXvp/WjGthEuuxVCqmH4PnNIHa6Hdg0/DHRC?=
 =?us-ascii?Q?YhACm5HOiEZ3CEK4PezuSm1IbZ9IGV/chbOSRdjPe4aEX3p+6FESDx5hzlUd?=
 =?us-ascii?Q?5hq9QsbIlYWxygv7XaLE6IBMyA8ueqlbUXlqBjwfGUhwMT9YtAunHRA5laCg?=
 =?us-ascii?Q?z0hZW6kWKDNWJUFCITaLcXfCivwetK7rJNnuGR5FZfxgy/mrz4nM5uMiYhkH?=
 =?us-ascii?Q?g1cR/+Bm1D+auScUJ+WctUn+g4IpLnqpuobzrVPh2toNwHTlq0wFU2sSsHkQ?=
 =?us-ascii?Q?onuv5Fi/jjr2HQizJFoA/0R0FycUFFFAwOpazkx6POA4QaK6z1RBtBhAPZUn?=
 =?us-ascii?Q?6God/ekDn6RsPcLC97SguSOa3523bcTCuqQHBouCbaudKDGRhAD02IH5TMLA?=
 =?us-ascii?Q?1TyrbfEMM1hMu8BGBiCscFtUqHy0vVYmnGaoXB+cGhPnrQvGXcnqk9Eo04t7?=
 =?us-ascii?Q?lklPxbDfODxvx1+3nId3FP3S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0845e0e-f517-4f1a-75c1-08d941669e74
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 16:45:25.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e5P0KHMW3tNVeI47HLfvCcKJvPCs89O7vTzpEDxFv/YIT7clbA8+WhhwDk55W43sXdHQ2+sSQTSqdzawCAPM6AUQq0rnxHOfaMVCnEKmAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4940
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=941
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107070096
X-Proofpoint-GUID: OykEPM9iFQNJzz2S8UphPkWNfFe39bnA
X-Proofpoint-ORIG-GUID: OykEPM9iFQNJzz2S8UphPkWNfFe39bnA
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jul 7, 2021, at 10:28 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Wed, Jul 07, 2021 at 10:23:04AM -0600, Eric Snowberg wrote:
>> 
>>> On Jul 7, 2021, at 12:46 AM, Christoph Hellwig <hch@infradead.org> wrote:
>>> 
>>> On Tue, Jul 06, 2021 at 10:43:51PM -0400, Eric Snowberg wrote:
>>>> This is a follow up to the "Add additional MOK vars" [1] series I 
>>>> previously sent.  This series incorporates the feedback given 
>>>> both publicly on the mailing list and privately from Mimi. This 
>>>> series just focuses on getting end-user keys into the kernel trust 
>>>> boundary.
>>> 
>>> WTF is MOK?
>> 
>> MOK stands for Machine Owner Key.   The MOK facility can be used to 
>> import keys that you use to sign your own development kernel build, 
>> so that it is able to boot with UEFI Secure Boot enabled. Many Linux 
>> distributions have implemented UEFI Secure Boot using these keys 
>> as well as the ones Secure Boot provides.  It allows the end-user 
>> a choice, instead of locking them into only being able to use keys 
>> their hardware manufacture provided, or forcing them to enroll keys 
>> through their BIOS.
> 
> Please spell this out in your cover letters and commit logs.

I will add it in the future, thanks.

