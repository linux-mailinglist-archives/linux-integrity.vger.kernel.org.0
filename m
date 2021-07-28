Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E528B3D9921
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Jul 2021 00:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhG1W5X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Jul 2021 18:57:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232163AbhG1W5X (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Jul 2021 18:57:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SMdwZh054192;
        Wed, 28 Jul 2021 18:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=4UR4y9o2kwbASX4z8Iqr7yq9Uxctz++9XV5hLrLEH7M=;
 b=IwdgyFHz6JHSmBG4itn6lLJXABK/Ssf2VGCv1DW9F06BGdPcUgc4EnDRQqM4FKSWn1AR
 N8d/G2pbWNfkEmtub5/7igzZP8YNfbfEsM0SUKc9Cb3UTnjLlXYLXJFOr6cXAsDfnQsp
 ndNK7xtWfdLw6yCK/pp0tUPo+DHPWNJXryYk4i+U39Eqp2PrGP4a+lBDhr2MsKYYRbji
 V8sdh37uLBTKVXCVSJlEm8io2SvUnSxWHEgVpuMYXf7bIcZ7rsOmKjCsK7jVMghdyXDs
 Gs5fq5uh/HdIPV6C6qSQ5fiJ65KXjMZyIIDF+pzTEAlUouFjBZXYv+iz/tIxNIsiIFIE CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a38tf6x6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 18:57:21 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16SMuAUS107332;
        Wed, 28 Jul 2021 18:57:20 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a38tf6x5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 18:57:20 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16SMvILr014944;
        Wed, 28 Jul 2021 22:57:18 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3a235kgvqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 22:57:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16SMvFvf30146872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 22:57:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7111A404D;
        Wed, 28 Jul 2021 22:57:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8234CA4053;
        Wed, 28 Jul 2021 22:57:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.118.100])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Jul 2021 22:57:14 +0000 (GMT)
Message-ID: <acf4fc349a59b4390e0ff57728f8f4920f89386a.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/5] IMA: introduce a new policy option
 func=SETXATTR_CHECK
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Wed, 28 Jul 2021 18:57:13 -0400
In-Reply-To: <20210728132112.258606-6-simon.thoby@viveris.fr>
References: <20210728132112.258606-1-simon.thoby@viveris.fr>
         <20210728132112.258606-6-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _lJbOpluf6CBVur8D0Pqje1hJ6bLteO8
X-Proofpoint-ORIG-GUID: Wr2RMeg6vB_-kSxUqvDyWhw4FlLDf_GF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_12:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280115
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Wed, 2021-07-28 at 13:21 +0000, THOBY Simon wrote:
 
> @@ -914,6 +918,42 @@ int ima_check_policy(void)
>  	return 0;
>  }
>  
> +/** update_allowed_hash_algorithms - update the hash algorithms allowed

The first line of kernel-doc is just "/**" by itself, followed by the
function name and a brief description.  The brief description should
not wrap to the next line.  Refer to Documentation/doc-guide/kernel-
doc.rst.

> + * for setxattr writes
> + *
> + * Update the atomic variable holding the set of allowed hash algorithms
> + * that can be used to update the security.ima xattr of a file.
> + *
> + * Context: called when updating the IMA policy.
> + *
> + * SETXATTR_CHECK rules do not implement a full policy check because of
> + * the performance impact performing rules checking on setxattr() would
> + * have. The consequence is that only one SETXATTR_CHECK can be active at
> + * a time.
> + */
> +static void update_allowed_hash_algorithms(void)
> +{
> +	struct ima_rule_entry *entry;
> +
> +	/*
> +	 * We scan in reverse order because only the last entry with the
> +	 * 'func=SETXATTR_CHECK' apply: this allows runtime upgrades of the
> +	 * digest algorithm policy, unlike the other IMA rules that are
> +	 * usually append-only. Old rules will still be present in the
> +	 * ruleset, but inactive.
> +	 */

Oh, my!  I really hope this won't be used as precedent.  Before
agreeing to this, the existing policy rules must require loading of
only signed IMA policies.

thanks,

Mimi
  
> +	rcu_read_lock();
> +	list_for_each_entry_reverse(entry, ima_rules, list) {
> +		if (entry->func != SETXATTR_CHECK)
> +			continue;
> +
> +		atomic_xchg(&ima_setxattr_allowed_hash_algorithms,
> +			    entry->allowed_hashes);
> +		break;
> +	}
> +	rcu_read_unlock();
> +}
> +

