Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57A13D55DD
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Jul 2021 10:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhGZILB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 04:11:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11610 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231844AbhGZILA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 04:11:00 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q8Vcvi001007;
        Mon, 26 Jul 2021 08:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3BNsUGrHnj2pBJskdMUXoa7xYFxNB0/XhB/byHZL8wo=;
 b=riVdh/pc+4R/9oFbnvjmnLvPtOzZAjxi17wCEBCY9KPaLp3y9MQujUxeeyo9jswExkcH
 uG9s82Ugdk3kYhD+TQa/mxZC6ey6MOfCKUdVcgGA+CFnQU1hajR60dNBQR1z7PuFr8Zg
 WUqSwB4lDm8Wg9TLnhWUu7zhvfWt0i6Z+3q2oFBnvVm8Na2yAiHRftYod31k8gfhfB+f
 9XA2dWuJCSucwX5BWMjFgiKTe/uHpiYy9XzHWd8NOXUDc/HjJbHD1dNCIGxVQgQnRtXk
 aImaca799IN2nYViIR1D51iWeKu9/maL7Us8U6lTj8YE1dqcEnJCIhwrpM6s2hw54OAS ig== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=3BNsUGrHnj2pBJskdMUXoa7xYFxNB0/XhB/byHZL8wo=;
 b=YfLgy3veIbhapc4J92JMv0x4VNSTEPQQlOhiZCflQ19exzAbH9sq7CFNcWZQQZafCChd
 6ypAjOWrg0DAnRi1kIzuv84/XoEmXjLcfhiRviqWc2Fv79c2AWtbA7nWDdRlrRTyNgAL
 u3YpBZS/rJwlS1PIrLz8ZF/mnPpoD6XS0cYenKe3DOEES9hjx44YBaspk8grSdbMBszI
 jW+uAaPE7CUV7n4n/7qAW5tyUeiDvSTpWvOYSQZlE0q13pvpZmtjCy5ft2SC6uCHc/e5
 Z3g2R2hUOHioOB0OPaVqhmWHGXJ9Tb4cjD2x7HV/ib6TK6opg5v69ZAkPlyBb7kqyxCt fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a18nfs1sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 08:51:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16Q8VR0c006884;
        Mon, 26 Jul 2021 08:51:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3020.oracle.com with ESMTP id 3a0n2fkhbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 08:51:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPo+MWnj64QYDKWkOSX2CtPwmYEMwb+r+hGUac92NCuLzctGY2oqCWdYjH1hUMaSsTfqZ//rEFZ0hzMs/7wpvYy9JGX9rdXQL6f0ZZPhK7xxZYEcDiWcbdbQCvPYL4BE/qS+kJ+XVpnoKdwczH1+pDTIfz1Aa/Uj8Lsx6HKoEYWRtq7s5AjB66Dp7itfeake865Qq9FEyTyhVILdewKvlSiWCa6c60GdoGHytmKVglsDfTJYipHGgCAxfLCB83tNRsf0MwAodLQ0BlxihrqqVLXsX6U1zOLGT7J8pMgRGK7rautHjLS71Nwn5TGViQhHJlh9mdd+QW0kbjI3vG218Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BNsUGrHnj2pBJskdMUXoa7xYFxNB0/XhB/byHZL8wo=;
 b=ZwvSGHHORz/fuP1v7nH47EZlMIbHhQ1IP7UKpa5a0P/fd6zoDzw5bQIWziBvU8qejGptRM5uYfbmCYbxD1rpdJfnHbhf0vc271yfxk/7wz+azKyUa/9lDMM+bRPrSOtehgLEiLWwcwTW29WsVbZ7mF1YaF3A59z5ubOqBWnBe3TLy+E+d1IehuPMZobqBcTspaTNeuiU+jwaWq76vhxzeF+Ccal0MXA/+Mra1J+KiUqUMkizIiJ2tTp1ZTl0oGWVWdibt1HdKOoumFUtQLTLKp8xkh97NnasDuqfKFrA9Fm9r6cznLLDqXbgfuedUG2VIrWFAJs3oZ6s2L5cv9U8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BNsUGrHnj2pBJskdMUXoa7xYFxNB0/XhB/byHZL8wo=;
 b=pwVtEZ+4E/ZVdoin4NvobcZZbTQ8uj2qdS/8U/qR8zVBIAYnEPN2i+ce6NM6pJrtGxxlsW3Kukn5Iu1hapIjKLeoN50XJW4CSbFJ3EkLFJq8V+f5AIkKBFkicKBURk8kN9VYH+HrlbahFmwHVlgHxYn/ggDEj2q7GbTUXrLiMDw=
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2320.namprd10.prod.outlook.com
 (2603:10b6:301:2e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.30; Mon, 26 Jul
 2021 08:51:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 08:51:12 +0000
Date:   Mon, 26 Jul 2021 11:50:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: keys: trusted: Fix memory leaks on allocated
 blob
Message-ID: <20210726085051.GG1931@kadam>
References: <20210723172121.156687-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723172121.156687-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Mon, 26 Jul 2021 08:51:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70ae5a2c-0ff4-42ff-0e63-08d950128491
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB232083933130B7124FA16F518EE89@MWHPR1001MB2320.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: favt1Vg10vFr20EGxPE4o0OarBlVomb2FnuIC0CfhIfrpa9ShKKzH8AGzYZ0nTRKrVS856dCaJRdrMk3eYXy6+kO7FVbpzbuZPHDniCjFsBDZQlXwNMs19EyxGaCMx9lPUBD09bllUF+HWF3PLOwrJHbgTs7QglbUdQ/GsYflukKhGNel5/6YaVcxyUoL9i788z37D9v8oNPA//PhTEREcvaNaoG7g8jtXrjSh3MFN7BDswJrbTKy9+OlMrRaiI8Wr14S8kMRkM3tQh2vlULNyjzoQuwPgCr1gJi9m0769guFacE2+UtqZQrJQtPm+xOZwxLFeL5M0Ib9Wnyl9vIRXlYr/7hRaKEYkLKI3cMp79RNB8SxeZ0xbZ7c3JTfqQUUcnf2gRdJoRRdUOjU2EIF6SXhYrx93zoLltybnPTgG7RSDgfcj4g6TxfxPvNotjbptTbNBhSvEN6df/5u1fMdqcqDpjEqPG5xmSkUl+nRCM/wMNCebDQyib7Yl86PF3sgBY0g+bHNEgdDbA39MYg7S2UvfyzdCqPK/c3rLB1xyUOlLhB2vJjkc/sxcKQ2ZpfoZe/jCWiQ4b8bNQs7wJNQelaFkqmJc5l+3C32FHOAqKAhSaphAHQzjpz8fx8WYRXpJpSr9VrtWjBmOFFlOEpOeeCJVOv63nkyFdxdnYv0nFkCap5hrXi4Fm/MBURSnb6xxxxU/UQdBEynZrbjiewEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(86362001)(44832011)(26005)(186003)(15650500001)(6916009)(6666004)(66476007)(66556008)(8676002)(9576002)(6496006)(38350700002)(38100700002)(8936002)(52116002)(7416002)(54906003)(66946007)(956004)(2906002)(33716001)(478600001)(9686003)(55016002)(83380400001)(33656002)(1076003)(316002)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Si+CuHeq7qCdB+keTWzSPwG9Fj8Rbsjtd43w41pvoCJpZhsNEzioCh07JoQn?=
 =?us-ascii?Q?AtS/MSK12yrfFmEZZ7QRov8xzRmXkyVpFRU3lB9gIHfiM7B9lRl+6JLlTwFT?=
 =?us-ascii?Q?x/V+6xBsjeHjp60Gl0OVXpUfA20oktnJuvy9oycFBRdiOjVEQ+tH5wdNXonv?=
 =?us-ascii?Q?vaQwcrXQynmU5XTFQLObO4VCqShQeYhXKGVclre4ClPZ/Wdkf0SWrzXiDWJh?=
 =?us-ascii?Q?ZdHOoZkbXvai7mHsfyYi55c9aSjBejpAEx7NPTvIC3g+2BSFeeyBS8NHQmeb?=
 =?us-ascii?Q?ybBTfIfPfpVp5YE4ym7Nucjv3qJwTwy4hsp/KxM0Nw9sCpNQGvEzXtpz734h?=
 =?us-ascii?Q?ZZc5ezkK+r8T4Lzfojo/40kOl1EOpTzorx9uQalNCYd9CEa1eXhtHnr/+GpE?=
 =?us-ascii?Q?z1vGjNU4QMxn6sQqTaj43xD5fuOUhE47WO7BlQsw6ZSw9yFmj+K8ZltVMZzF?=
 =?us-ascii?Q?hR9JLJHv7JWS1K0hkEdxF4ttx+qhpiFiSYC841xrMyt+/JZp3iISlpelZaR8?=
 =?us-ascii?Q?TpWMPeuoO+Z43YVxFtJjLLc6kmZSiwIj9wZ2Vqv+UENO6J/sokS+WOZeEGus?=
 =?us-ascii?Q?vd5yzZh+qLIzT4Zc8T0NAs0FhDqb7WiaruUAodVEEXNqmulq8aR4rwfG1m/J?=
 =?us-ascii?Q?MtbrypRjSzBKKadlos9Em+e/h+T03NNRFbEF1AtOkRVvgCpCLr8zzCyxuX2Q?=
 =?us-ascii?Q?PhXEnAqMfiCOrx2tgZYUGqHjUHmGHIZnMbvkG9139MEmg6zkBUhIHaDdWEuh?=
 =?us-ascii?Q?JJnbp8g2+LbKU8o3sCBLbBrtY5xT/qHV78lgY7ACxV/n1p9b5FlIy3PWynJv?=
 =?us-ascii?Q?37n5vSt7k+MB6FS9CSILHz39LzkQnu2pK1zusDTNAlG81pOsCtxnKTkjZiK9?=
 =?us-ascii?Q?LMLnJZb/E70/igQMKQCKU8hlsw5Fk6sHNTjTMrLcISdS8C3RdyFJO1KL97w5?=
 =?us-ascii?Q?dNDSXNbfW8OF4A33n0m8TNJIIuWS49+I6MgWgJMdlKt2bpG/QyrSwj22paZP?=
 =?us-ascii?Q?J0ws8HTFLNK4uj0/OSFQIG2HMyOUK5LjXjSRWHnj+CDLupXYcLCj61j4L1iS?=
 =?us-ascii?Q?XS27AGUlZKLDY3lPolfOlS5Twn8DoVF4gLKAvFPKZ2rtBGE6WFwfWCnDgwy2?=
 =?us-ascii?Q?RtGJG2GMeY7oCV3DEkeGk3MgZxeRDd0GMdwPVckXku9RNqbQ/P+uy/mKSvhz?=
 =?us-ascii?Q?eqoBa03mB27ruZ0VnqSbOhlqixKEWejVNOHN12PRZK+EKmlcCMj2rIguttAu?=
 =?us-ascii?Q?MDFFRSGGvMSIcn8x+GSsJx5Kx9FA0ANxdYjRCC1FTPVpOdpRp/S0+K/midAg?=
 =?us-ascii?Q?zazBLKCNksqy0cqB3VgJCYDw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ae5a2c-0ff4-42ff-0e63-08d950128491
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 08:51:11.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZHimt9VrLfpU3Ylwn5+Q72c9WveEgzSTC5GLKUY7cCoB/CIMB6F2+KhVRhEwOUMH8SzluhBAVibutMzPs/F4ARp9bDeZ5Mi3DvTxVcdPC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2320
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10056 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=982
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260050
X-Proofpoint-GUID: 3JT2nxvxsy0ZrjVJQyyuAewBmciiT2xJ
X-Proofpoint-ORIG-GUID: 3JT2nxvxsy0ZrjVJQyyuAewBmciiT2xJ
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jul 23, 2021 at 06:21:21PM +0100, Colin King wrote:
> @@ -441,6 +449,10 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  		rc = -EPERM;
>  
>  	return rc;
> +
> +err:
> +	kfree(blob);

This needs to be:

	if (blob != payload->blob)
		kfree(blob);

Otherwise it leads to a use after free.

> +	return rc;
>  }

How this is allocated is pretty scary looking!

security/keys/trusted-keys/trusted_tpm2.c
    96  static int tpm2_key_decode(struct trusted_key_payload *payload,
    97                             struct trusted_key_options *options,
    98                             u8 **buf)
    99  {
   100          int ret;
   101          struct tpm2_key_context ctx;
   102          u8 *blob;
   103  
   104          memset(&ctx, 0, sizeof(ctx));
   105  
   106          ret = asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
   107                                 payload->blob_len);
   108          if (ret < 0)
   109                  return ret;

Old form?

   110  
   111          if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
   112                  return -EINVAL;

It's really scary to me that if the lengths are too large for kmalloc()
then we just use "payload->blob".

   113  
   114          blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);

blob is allocated here.

   115          if (!blob)
   116                  return -ENOMEM;
   117  
   118          *buf = blob;
   119          options->keyhandle = ctx.parent;
   120  
   121          memcpy(blob, ctx.priv, ctx.priv_len);
   122          blob += ctx.priv_len;
   123  
   124          memcpy(blob, ctx.pub, ctx.pub_len);
   125  
   126          return 0;
   127  }

[ snip ]

   371          u32 attrs;
   372  
   373          rc = tpm2_key_decode(payload, options, &blob);
   374          if (rc) {
   375                  /* old form */
   376                  blob = payload->blob;
                        ^^^^^^^^^^^^^^^^^^^^

   377                  payload->old_format = 1;
   378          }
   379  

regards,
dan carpenter

