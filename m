Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136303E95E3
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 18:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbhHKQ11 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 12:27:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhHKQ11 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 12:27:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17BG4fBH073943;
        Wed, 11 Aug 2021 12:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8SlUOnW837HY1QeI8Esn83utWQIHhiNZb3oyLXdIAFg=;
 b=QVYbnQQwWNVjGxjRHDRE4UVoTDZ7RXKaytcGRRCbHJPjtBldn87xu6Q5Lem01lOboFe1
 dLADg2BHSsmn9t3hUyI7cBdyGGf+Xi0uFYZb0KUZaJjVLcSkFNkOxpFRgLKD7QpSdiWc
 oxBs/gObTPFbOtm9ZkdXNOS1yF+6nx+hAX9A/DOAmBSVjHt+Hc1/0SQgNpRE5jXxCWkY
 UgnM111ut8W9y/ZgopeDNQrGLz+zRhSUnpFzcuD53u3uvv4ywyMhihA9oqgWXF1H2mV+
 w5cIpglMZ2zxwNTlgRuHXWykOLipTAqP11Yw6bL2CMZpgG29r0tBGckt5Jx9JZ5d2Ff4 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abrr5yfx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 12:27:02 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17BG5NqA077953;
        Wed, 11 Aug 2021 12:27:02 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3abrr5yfvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 12:27:02 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17BGOUxZ027286;
        Wed, 11 Aug 2021 16:26:59 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3acfpg85d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 16:26:59 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17BGQulh52494720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 16:26:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B020142054;
        Wed, 11 Aug 2021 16:26:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7D104204B;
        Wed, 11 Aug 2021 16:26:55 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.27.84])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 11 Aug 2021 16:26:55 +0000 (GMT)
Message-ID: <84b3a572eb5fc1ec81291656c9f9af00568bff9f.camel@linux.ibm.com>
Subject: Re: [PATCH v7 4/5] IMA: add a policy option to restrict xattr hash
 algorithms on appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Wed, 11 Aug 2021 12:26:54 -0400
In-Reply-To: <20210811114037.201887-5-simon.thoby@viveris.fr>
References: <20210811114037.201887-1-simon.thoby@viveris.fr>
         <20210811114037.201887-5-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vawKBUfp3dZMCLmhes_VEJFlnIaBFLUX
X-Proofpoint-GUID: 6gxFTLeunbp4SAKkqRR_tzyQcCNpFg40
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-11_05:2021-08-11,2021-08-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108110108
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Wed, 2021-08-11 at 11:40 +0000, THOBY Simon wrote:
> +static unsigned int ima_parse_appraise_algos(char *arg)
> +{
> +	unsigned int res = 0;
> +	int idx;
> +	char *token;
> +
> +	while ((token = strsep(&arg, ",")) != NULL) {
> +		idx = match_string(hash_algo_name, HASH_ALGO__LAST, token);
> +
> +		if (idx < 0) {
> +			pr_err("unknown hash algorithm \"%s\"",
> +			       token);
> +			return 0;

Previous versions of this patch ignored unknown algorithms.  If not all
of the algorithms are defined in an older kernel, should loading the
policy fail?   As new IMA policy features are defined, older kernels
prevent loading newer policies with unknown features.   I hesitated to
equate the two scenarios.

> +		}
> +
> +		/* Add the hash algorithm to the 'allowed' bitfield */
> +		res |= (1U << idx);

This assumes that all the hash algorithms are enabled in the kernel,
but nothing checks that they are.  In validate_hash_algo(), either the
allowed_hashes is checked or the hash algorithm must be configured.  Do
we really want a total separation like this?

thanks,

Mimi

> +	}
> +
> +	return res;
> +}
> +

