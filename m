Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B833E4B13
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 19:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbhHIRoW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 13:44:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42926 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234154AbhHIRnn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 13:43:43 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179HWpBA092664;
        Mon, 9 Aug 2021 13:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=zjb4N9O9booqximE72gTzjJl38+k1RCRBCZCBUn7yo0=;
 b=l3YtlQ/e8vKNoLSPU1PcrydQcZo/hdEUxoHPsmWahyWSKOk8mN3DLFNv1pGIXshWgSLQ
 /frRZG0pEl2myBxIiZiA+8YdAFTf3/RArUE4pV/c8CnE5p2UpRjJRgl3bsK8lbgDZUzN
 FuhPUHLzzlvGXDvT0ckpQ1/Z3yJlz0vIcwvTFJmWasX/r/r31yKW8FLTrgm+LoKjq10a
 WfMTtGCLEbLSIes+SpFCDvfziLI4YN/1rL2ThjeY9JKU5pF55hvhBLi3qp3ZPH4P8LZl
 0Gkw+C6LuL12ZhZ94aQu+1ZaOyVqmNcTtbN6eiZMFm3UqmSL3/9fgVkesh2/jus6pgFD ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab86x1dup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 13:43:22 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 179HX5kT093276;
        Mon, 9 Aug 2021 13:43:22 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab86x1dty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 13:43:22 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179Hg7xj029923;
        Mon, 9 Aug 2021 17:43:20 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3a9ht8vepc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 17:43:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179HhHwi56754566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 17:43:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62C645204F;
        Mon,  9 Aug 2021 17:43:17 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.79.43])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5952552054;
        Mon,  9 Aug 2021 17:43:16 +0000 (GMT)
Message-ID: <c1dadaa101b041fc7dcde1a5b3b52593a949e992.camel@linux.ibm.com>
Subject: Re: [PATCH v6 3/5] IMA: add support to restrict the hash algorithms
 used for file appraisal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Mon, 09 Aug 2021 13:43:15 -0400
In-Reply-To: <20210804092010.350372-4-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
         <20210804092010.350372-4-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VIhFUog8s2ugTliut-vAAlGbsSRTA7na
X-Proofpoint-ORIG-GUID: H9PoiAABV6v96pd3ipvX_ncFyDiBDNg_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_06:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090124
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-04 at 09:20 +0000, THOBY Simon wrote:
> The kernel accepts any hash algorithm as a value for the security.ima
> xattr. Users may wish to restrict the accepted algorithms to only
> support strong cryptographic ones.
> 
> Provide the plumbing to restrict the permitted set of hash algorithms
> used for verifying file hashes and digest algorithms stored in
> security.ima xattr.

simplify by saying "file hashes and signatures stored ..."

> 
> This do not apply only to IMA in hash mode, it also works with digital
> signatures, where the hash from which the signature is derived (by
> signing it with the trusted private key) must obey the same
> restrictions.

The patch is limited to appraisal.  Is the above paragraph needed? 

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

This patch restricts the "hash algorithms".  Looking this over again
after some time, does truncating variable names here, and in the other
patches, to just "_hash|_hashes" make sense?  Perhaps the emphasis
should not be on "hash", but on "algo".

> @@ -684,8 +695,11 @@ int ima_match_policy(struct user_namespace *mnt_userns, struct inode *inode,
>  			action &= ~IMA_HASH;
>  			if (ima_fail_unverifiable_sigs)
>  				action |= IMA_FAIL_UNVERIFIABLE_SIGS;
> -		}
>  
> +			if (allowed_hashes &&
> +			    entry->flags & IMA_VALIDATE_HASH)
> +				*allowed_hashes = entry->allowed_hashes;
> +		}
>  
>  		if (entry->action & IMA_DO_MASK)
>  			actmask &= ~(entry->action | entry->action << 1);


"allowed_hashes" sounds like a set of digests.  Instead of
"allowed_hashes" and "IMA_VALIDATE_HASH", should it be "allowed_algo"
and "IMA_ALLOWED_ALGO"?

thanks,

Mimi

