Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A6414858
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhIVMEE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Sep 2021 08:04:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2092 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235848AbhIVMED (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Sep 2021 08:04:03 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MBgBYN021542;
        Wed, 22 Sep 2021 12:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3sBFhZFoVNSwTq83JmmHVujhXJNQniK4m+OgvBy2IP4=;
 b=f+U5n9f5UnwQ2s1jiJYFBZNdoeBx6bn1vcm3/N5QBkwBJCNHMCr39BUYpwc2x2pd+V+U
 9uCCALMmPzfZYWYc3eygLL9gkub1l+xCu22shQHR6n7sTv11a3zQe10v7eXJWte1X30m
 UW4CxrFR3NjoZU4r6ElZHwTey2yJzsJDbwHHqpYuGP+pYPMpFqcFPYOfup5vRTZCkJIW
 /bkp6CvAW+NptqXNTwfGyaxe2Lb53hwKU1HmqJ6IbV9FfmM7ebYbmNMOODN1fiv1huv/
 MfvdXDNJ3+XlH/2WLvpe8Dpd7/WiD/9hjQuGdmKGOciKxLWH3/9lkN6t+gY4SEKRNNwK ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b7q4p39un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 12:02:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18MC0qXS072086;
        Wed, 22 Sep 2021 12:01:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by aserp3020.oracle.com with ESMTP id 3b7q5ajeut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Sep 2021 12:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqN3yMVIYzl/hmOYAXc4yMCysLmqsHnKF/fPyZrECvVh53oGrROgCASGmKKM9EVg2TCZNSO8a+uNEgsa+lOZssDvX//nJ5Gy1PIghcP41KDrnWdLOSNQRTs59mdWQ1p2B9RXvo8Pf4umT5WoUzhUZTXXXAlb0iCfGx6wKbQTMEm4M8q+ZLeLVbLZIiWbX07MnYjTSA9m+SuqzNiAJajpn1E3bDdhPInKFRP/SkGVu8hIbz865KgrITjA5nJyuDftt3QRRj4ovsNgoTDOgRB/O/aCPRU6OyXSvJeG/ilCF5RplL6F1u85QVfAY5/W4itZgxzy7ihDGhbP+FPKvRQSbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3sBFhZFoVNSwTq83JmmHVujhXJNQniK4m+OgvBy2IP4=;
 b=JVe4o45SezHgrSGntx+Hg4roPeoDvKyjqkrqZ6VAWIFHfEbtpvRsyp69Tod2RfweW2lvQy9AXOF+oL4TQx+apGULrZ21hDhz9V1f70+4LjxXk0O6eu0aAowDKjptDJl6CTX4E1a9Y/dxj21/c1y+TVcYF4g8erNyw4NYDhV6km9Dn/BQDG5f7h65l3Mmhwblzp4pYu1/HlzmJGBBzgy+nP5uRvgu4A5o0DVnK1Qcv72fs1f7Wp/QZQ5FhP1oZ2wVhzzf+7+1UVyFe/YVE4hm7xTQZcSjwXFBixgi5y7g/nzVqoa9Oax+Wv9R4KMSh4D7bpQIES2KBvn6OQ2nJ+DS7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sBFhZFoVNSwTq83JmmHVujhXJNQniK4m+OgvBy2IP4=;
 b=uitIkPhJZkSwRdDD1yEi3n5v0KeLHw22hdYOUO4XN0INGQV5aOitB0SBGr9pWIXmdOir081uU51nUL4M5f6w9Wr8KNmNtnSHcg/bZ80L7sXzIjdr44shocucD5/Ad2IVZvSw/+UmwyO+VXfJavcfiUXMJnsp75W9BSQydxMP2SE=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR1001MB2228.namprd10.prod.outlook.com
 (2603:10b6:405:2e::38) by BN6PR10MB1380.namprd10.prod.outlook.com
 (2603:10b6:404:45::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 12:01:47 +0000
Received: from BN6PR1001MB2228.namprd10.prod.outlook.com
 ([fe80::3cca:22b1:cbcf:eeed]) by BN6PR1001MB2228.namprd10.prod.outlook.com
 ([fe80::3cca:22b1:cbcf:eeed%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 12:01:47 +0000
Date:   Wed, 22 Sep 2021 14:01:37 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        luto@amacapital.net, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v4 01/14] x86/boot: Fix memremap of setup_indirect
 structures
Message-ID: <20210922120137.3smvvedpxroi7bkw@tomti.i.net-space.pl>
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <1630070917-9896-2-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630070917-9896-2-git-send-email-ross.philipson@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM5PR0602CA0018.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::28) To BN6PR1001MB2228.namprd10.prod.outlook.com
 (2603:10b6:405:2e::38)
MIME-Version: 1.0
Received: from tomti.i.net-space.pl (84.10.22.86) by AM5PR0602CA0018.eurprd06.prod.outlook.com (2603:10a6:203:a3::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend Transport; Wed, 22 Sep 2021 12:01:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa8aab86-2058-4d1f-26cd-08d97dc0c08b
X-MS-TrafficTypeDiagnostic: BN6PR10MB1380:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR10MB138033D4DD81F37E79484753E3A29@BN6PR10MB1380.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WT6r6OvtNW2XKjcx/hejjc87c8dW64ACyyPQUN/odj9iwNo+7Z/VOog7xhwT50mrMPHDxCo1RBi6ick4FHTrwhNoyecu6RY3tHRFHprBainzyZIIuoHxJwSKude3m81tuEHQ90weVbhgPYu/anf2NBRb4pLU19Hd9U0LeLSxss+pxBrjLHMKSO3wzjgOsccroCxXJYV2beSv8rdZGHUsXPzJC7BrLtqZ/jQUk1eAGbWEIL48iE7FcktZm4KAYjjTomJ0YhtjvxsKuEgCNhaiHE9QKkZs8aOE/OzCutSYb46Lxok7twoaXMPGdgZDD72ngf4AfI+G4BqNm7ZDmE7713E4fRXsfEdjZyCUxBhjsfPHfsfvs2y+wj4DjeVvdxjIqoqmCaZYbACzJsDaRZEI1zC3JBY0oXe3Ud5HbyO2vDpUtUnBCCmUxoAASlylKn0MEDvdBcRK1VXXEuSrHCgMqmKstfDgFSOZPpUGHWnEryo9i7dupICADxOWWpeR4r69haAzd1U2v971RxxESOl9ixfNvo2GB8jxBhOJdj7ypq3t5SnWnTnH88pMb5arX9Exj8YCVgaSREqPdyAdBFQjKK6pLnbIhqGe1Y74oNhkBSS4CwVbmuagb3vcpar1wxu1Jun35+o/3fDHiODpiV/QI0p9shoNZNlvYzQ8XdetPPt5BOvPGRa14QXUxabX62a6iFiL/WNY73IwljfnyCe25Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(66476007)(316002)(66556008)(5660300002)(1076003)(8676002)(4744005)(6506007)(6636002)(6666004)(7696005)(6862004)(7416002)(186003)(2906002)(956004)(38350700002)(44832011)(38100700002)(4326008)(26005)(83380400001)(55016002)(508600001)(8936002)(86362001)(9686003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RW69mn7RYifo/V9W3cBbLKttOBMA16GHOty5ruGBvz4C0wO0r9N/b1WnxOCJ?=
 =?us-ascii?Q?DdsOy2Dg9GcuvTKRkEc4p3L41lnlAeF4Vxw5eiZsp0KZJtOJPN5gaGdg5BD+?=
 =?us-ascii?Q?2mL+fbQlfC1J3SHxGa+GArc6+oqdtj8OV7dgWKw22FojTcbthQ3IpzbEqQCx?=
 =?us-ascii?Q?zZZbq0YD/4v1SfrqgFrDb2cURKFwL/CbURdexP2ovZB9Iz88UJ7XWS5tlmlL?=
 =?us-ascii?Q?xxSpQT6HPWcwIa6tSUtcre0hPXIfbvg5MdI1cXT9bztloxbJEaMsldu7A95R?=
 =?us-ascii?Q?Sj41N61jGpTM1YkKh/uTynuVl+FUysz4tCVqMGoQrz7UCgnELDpn+jO8DV4s?=
 =?us-ascii?Q?UDIUHNWzKYezg6P7xxgNVFhEZ99Z1wFon72TvrdBiW53TD82beJQecikh1Cq?=
 =?us-ascii?Q?/CEm2DUC2QhbiyRRa3Kr22Y3Xvb6YFogq5nbpxJMU17UDGEvCMZdI0KmpuV2?=
 =?us-ascii?Q?TfMMVrokJhQyxymnSgFkYsFC6fQrpICZ1JZPwuLvaxdbLgZnmt7UTZQMV8Bn?=
 =?us-ascii?Q?ALC8HX0KNzldpiq/fhyUM/Urlp+Tyq3tEMI0eInf3cuJe0qUqZ4JIgGXkxVd?=
 =?us-ascii?Q?Z0LbhSSKMX0LefkTc/4KGtwnxOLjDdd/IiS2ON4pn4diELX2EWLNR4grcQiw?=
 =?us-ascii?Q?gu6MPvA5g/Hid7sTWHHQxCvjdRfNxAXhyHJF/SUE0fSi5dtw9GvqNXOAJjMO?=
 =?us-ascii?Q?/oGOrETO7AjawMMMv/nllCpEglNp6nKTvevF6pjDye8tEnMazQh7loqzdLtx?=
 =?us-ascii?Q?PwYFeUBk/JW/yhahEm05+wElU/1rDoNIV7PM9On0Y73nWy5Qu4mFxl1nLOpg?=
 =?us-ascii?Q?1xTHis1K6YJZMfxY+cV9BRoTZvOQ1AiH2yeQqyeMY1VaO1oCJ6ehOJF3N57o?=
 =?us-ascii?Q?fbLEDOOc5rCP3DIl4IVlL9jYz7hucqbmlZsgX8UqvgSmjVqB0ClLkGTDNh+l?=
 =?us-ascii?Q?7KlmVSKY3hXoqRmiiT1RZEMaXrRJdeqt5XdPMYfS7MTy0xz+2ni8u933JVZ/?=
 =?us-ascii?Q?X3CFbuGmnwVOM6AodpXEin50GTSZwF0YbvWfjT42hPM7qI8WsWIxZlS1l8n/?=
 =?us-ascii?Q?DdXB5brUCPZHhtGnllz+379/Hni8zDT0h1RBoGCnWAfn6VgIgT2JpNgiofiG?=
 =?us-ascii?Q?tXZfAagNyj962ObAOwAAmjLoxikhIxAwDA5/qQdQnIVRBw2Qf7aD6EhIK9zr?=
 =?us-ascii?Q?pQ80AZCSuBWeVDOqQVJsCIvwgo7MxpD2mDKLAoWTQ61MeGpNg6X7xFuCtAgX?=
 =?us-ascii?Q?kVrWFRWiwkwtdISj7yNWNz26anlIM36fhdAMaROT/MVqRQP76wOyTumBQESC?=
 =?us-ascii?Q?0X/fNVUoN6QbA+IpvcqePf7b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8aab86-2058-4d1f-26cd-08d97dc0c08b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 12:01:47.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSNYRrnBlEQzY1Sr1I2hijy4NHJONGTVB8i4benxNH226b8p8ZE3ISROJ9FQDCFOZW2/sKP1b/1dVuOAHBIClg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1380
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10114 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220085
X-Proofpoint-GUID: a314SK0ROoq0Q0UhakaBAdyllWTqP0yr
X-Proofpoint-ORIG-GUID: a314SK0ROoq0Q0UhakaBAdyllWTqP0yr
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Aug 27, 2021 at 09:28:24AM -0400, Ross Philipson wrote:
> As documented, the setup_indirect structure is nested inside
> the setup_data structures in the setup_data list. The code currently
> accesses the fields inside the setup_indirect structure but only
> the sizeof(struct setup_data) is being memremapped. No crash
> occured but this is just due to how the area is remapped under the
> covers.
>
> The fix is to properly memremap both the setup_data and setup_indirect
> structures in these cases before accessing them.
>
> Fixes: b3c72fc9a78e ("x86/boot: Introduce setup_indirect")
>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

This is the fix. So, I think it should be taken now, regardless of the
fate of the other patches in the series.

Daniel
