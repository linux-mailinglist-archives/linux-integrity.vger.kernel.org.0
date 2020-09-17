Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA9626DBA6
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 14:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgIQMeK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 08:34:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbgIQMdP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 08:33:15 -0400
X-Greylist: delayed 1869 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 08:33:02 EDT
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HCWp5j089002;
        Thu, 17 Sep 2020 08:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pScfLEw4/3IWzMLleXg0b7p6NNW5+YGucCmoypNRfGY=;
 b=ptXjsyFPL1oNBJfUdoU8JnIioemK31DRitis0dccg5/xJvRBnd/E0bknfA7E1doqQat6
 09eK5u0FUeHJk6meiTUtF7JtGY2aSR9NTDg96eEIT8V8V7X/hg4Y98gP2t1Yr0YTwr5q
 cRHVoYcMM89ik0dMucFNtDvOAdBjUTuGH83PRuWOmeJDq4J6wAW2jo4cZP4xW9oR8mQZ
 TgFwoQNkpKdj3tOQ2eD8D55T7Pp8A99P7iBuudrGjabFqlcfl1sPCZp/pWvc0JEArMbI
 fCYIZXdf/3J9NlhdjZ4LuWcjLaEMsKn8M0VlrzT+em8d5V5uDElr1WeJi544jY0i2+jN jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m7fb8us4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 08:32:53 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HCWp6F088998;
        Thu, 17 Sep 2020 08:32:51 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m7fb8uek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 08:32:50 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HCSjPg011949;
        Thu, 17 Sep 2020 12:32:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 33k6esj3jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 12:32:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HCWJl230802304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 12:32:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FA8B42049;
        Thu, 17 Sep 2020 12:32:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9645642052;
        Thu, 17 Sep 2020 12:32:17 +0000 (GMT)
Received: from sig-9-65-208-105.ibm.com (unknown [9.65.208.105])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 12:32:17 +0000 (GMT)
Message-ID: <03e55547ff7c8725a73f60c460deb13a5b135531.camel@linux.ibm.com>
Subject: Re: [PATCH v2 08/12] evm: Allow xattr/attr operations for portable
 signatures if check fails
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 17 Sep 2020 08:32:16 -0400
In-Reply-To: <20200904092643.20013-4-roberto.sassu@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
         <20200904092643.20013-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_08:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 suspectscore=4 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

"if check fails" in the Subject line is unnecessary.

On Fri, 2020-09-04 at 11:26 +0200, Roberto Sassu wrote:
> If files with portable signatures are copied from one location to another
> or are extracted from an archive, verification can temporarily fail until
> all xattrs/attrs are set in the destination. Only portable signatures may
> be moved or copied from one file to another, as they don't depend on
> system-specific information such as the inode generation. Instead portable
> signatures must include security.ima.
> 
> Unlike other security.evm types, EVM portable signatures are also
> immutable. Thus, it wouldn't be a problem to allow xattr/attr operations
> when verification fails, as portable signatures will never be replaced with
> an HMAC on possibly corrupted xattrs/attrs.
> 
> This patch first introduces a new integrity status called
> INTEGRITY_FAIL_IMMUTABLE, that allows callers of
> evm_verify_current_integrity() to detect that a portable signature didn't
> pass verification and then adds an exception in evm_protect_xattr() and
> evm_inode_setattr() for this status and returns 0 instead of -EPERM.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

< snip >

> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 05be1ad3e6f3..a5dab1ac9374 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> 
> @@ -358,6 +364,12 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
>  				    -EPERM, 0);
>  	}
>  out:
> +	/* Writing other xattrs is safe for portable signatures, as portable
> +	 * signatures are immutable and can never be updated.
> +	 */

This is the second time I'm seeing this comment format style.   Why? 
What changed?

Mimi

> +	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
> +		return 0;
> +
>  	if (evm_status != INTEGRITY_PASS)
>  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  				    dentry->d_name.name, "appraise_metadata",

