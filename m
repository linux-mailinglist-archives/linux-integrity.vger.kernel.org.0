Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F250125085A
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 20:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgHXSpO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 14:45:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725963AbgHXSpO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 14:45:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OIXRTr103537;
        Mon, 24 Aug 2020 14:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jat0l1ha5CWfyGYW+fPRuRE7JGRu/aQnypEyLMpRrHM=;
 b=G+dwn4YVDJuPBeADjjZSqEueVEU7ge0cf0q/2X7lzooPP5JaSJuwlPXUbzj52LBxZRYz
 8pxSNasvgEBKcZyWeWm5sHYTnp8V5UVIDDnVKFe4kmP12ZITt+pCErXS0H31KGwd66MH
 /BGoHnh1J3k9m0ZCl2XrjlraLJnHSGIXwC+JlWqlGlsCwgwo4vL+RG6doC+qHyB1SPJD
 XGY+fW5qL5ihngviGElNQeofdebT+6mqg8L0dEiL8fY9Sp/YoxIHhUDLRWoyTdwEMoHs
 BNN+mf/QRVTK0woiPhGZOGcW53mzQJTGcphkWSG3GlXyRb1fZKGoZSnIhF7MHa0OGzbC aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334j2asv36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 14:45:04 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07OIXRQh103520;
        Mon, 24 Aug 2020 14:45:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334j2asv27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 14:45:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OIRfEg001870;
        Mon, 24 Aug 2020 18:45:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 332ujktn4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 18:45:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OIiw5e16646654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 18:44:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE01C11C04C;
        Mon, 24 Aug 2020 18:44:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4539E11C052;
        Mon, 24 Aug 2020 18:44:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.122.56])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Aug 2020 18:44:56 +0000 (GMT)
Message-ID: <839d2b185ba482d664edd3fda7c03965543553fa.camel@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] ima: Fix keyrings race condition and other key
 related bugs
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Mon, 24 Aug 2020 14:44:55 -0400
In-Reply-To: <20200811192621.281675-1-tyhicks@linux.microsoft.com>
References: <20200811192621.281675-1-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tyler,

On Tue, 2020-08-11 at 14:26 -0500, Tyler Hicks wrote:
> v2:
>  - Always return an ERR_PTR from ima_alloc_rule_opt_list() (Nayna)
>  - Add Lakshmi's Reviewed-by to both patches
>  - Rebased on commit 3db0d0c276a7 ("integrity: remove redundant
>    initialization of variable ret") of next-integrity
> v1: https://lore.kernel.org/lkml/20200727140831.64251-1-tyhicks@linux.microsoft.com/
> 
> Nayna pointed out that the "keyrings=" option in an IMA policy rule
> should only be accepted when CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is
> enabled:
> 
>  https://lore.kernel.org/linux-integrity/336cc947-1f70-0286-6506-6df3d1d23a1d@linux.vnet.ibm.com/
> 
> While fixing this, the compiler warned me about the potential for the
> ima_keyrings pointer to be NULL despite it being used, without a check
> for NULL, as the destination address for the strcpy() in
> ima_match_keyring().
> 
> It also became apparent that there was not adequate locking around the
> use of the pre-allocated buffer that ima_keyrings points to. The kernel
> keyring has a lock (.sem member of struct key) that ensures only one key
> can be added to a given keyring at a time but there's no protection
> against adding multiple keys to different keyrings at the same time.
> 
> The first patch in this series fixes both ima_keyrings related issues by
> parsing the list of keyrings in a KEY_CHECK rule at policy load time
> rather than deferring the parsing to policy check time. Once that fix is
> in place, the second patch can enforce that
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS must be enabled in order to use
> "func=KEY_CHECK" or "keyrings=" options in IMA policy.

Thank you for fixing and cleaning up the existing keyring policy
support. 

> 
> The new "keyrings=" value handling is done in a generic manner that can
> be reused by other options in the future. This seems to make sense as
> "appraise_type=" has similar style (though it doesn't need to be fully
> parsed at this time) and using "|" as an alternation delimiter is
> becoming the norm in IMA policy.

Yes, thank you.  Better extending existing key value pairs than
defining new boot command line options.

This patch set is now queued in next-integrity-testing.

Mimi

