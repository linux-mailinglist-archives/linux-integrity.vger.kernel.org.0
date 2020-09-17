Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA16626DCAD
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Sep 2020 15:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgIQNQU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Sep 2020 09:16:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48872 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgIQNQB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Sep 2020 09:16:01 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HDCpfe110398;
        Thu, 17 Sep 2020 09:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=enh8OcIBw43YmJKaYzY58QOrw1oBaNAWROv4I7Cq1ZY=;
 b=ZHCPf4WAOsRx+0bdEUjngXLxGjJUMWD3kzkgbIv06DIJM/+WJPMaNmiUUs9Hkt3eccqf
 MDitTBOe5zVSKoT7ELcLYc8cN7Ekqcb2gs4vXsh/+Mp1K/dkIqcmYaAXP3ML+mUKhoVw
 gRI62nUOXS9Aaf0PQnGzMVSSyT3Hz4YCFClyKkidovkaHATGkeKm6ke+7pt0cVGLh9lN
 aokJjd+j+xKdrBEcuRH5R1V4L2yEDADlt2M2B+HRP6hXI39QB5h4Cy+etbPiZFuoy9mU
 MNXil49ZOsxxY5a+UOf1081DQeVxdXLS2XalWXyY3niFw0gorpcesKS1rhcFH6kMsOcc tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m8g0g2vk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:15:50 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HDFNKQ124507;
        Thu, 17 Sep 2020 09:15:49 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m8g0g2u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:15:49 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HDDH5Z005652;
        Thu, 17 Sep 2020 13:15:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 33k5v993s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 13:15:46 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HDEAoY34341286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 13:14:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2E364C044;
        Thu, 17 Sep 2020 13:15:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30CB94C04A;
        Thu, 17 Sep 2020 13:15:43 +0000 (GMT)
Received: from sig-9-65-208-105.ibm.com (unknown [9.65.208.105])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 13:15:42 +0000 (GMT)
Message-ID: <65512863d3cee25b0ba40fce8e819772b20c363c.camel@linux.ibm.com>
Subject: Re: [PATCH v2 09/12] evm: Allow setxattr() and setattr() if
 metadata digest won't change
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 17 Sep 2020 09:15:42 -0400
In-Reply-To: <20200904092643.20013-5-roberto.sassu@huawei.com>
References: <20200904092339.19598-1-roberto.sassu@huawei.com>
         <20200904092643.20013-5-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=3
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170098
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Roberto,

"if" doesn't belong in the subject line.  In this case, instead of "if
metadata ...", how about something like "for unmodified metadata"?

On Fri, 2020-09-04 at 11:26 +0200, Roberto Sassu wrote:
> With the patch to allow xattr/attr operations if a portable signature
> verification fails, cp and tar can copy all xattrs/attrs so that at the
> end of the process verification succeeds.
> 
> However, it might happen that xattrs/attrs are already set to the correct

^ the xattrs/attrs

> value (taken at signing time) and signature verification succeeds before
> the copy is completed. For example, an archive might contains files owned

^ has completed.

> by root and the archive is extracted by root.
> 
> Then, since portable signatures are immutable, all subsequent operations
> fail (e.g. fchown()), even if the operation is legitimate (does not alter
> the current value).
> 
> This patch avoids this problem by reporting successful operation to user
> space when that operation does not alter the current value of xattrs/attrs.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

<snip>

> +/*
> + * evm_xattr_change - check if passed xattr value differs from current value
> + * @dentry: pointer to the affected dentry
> + * @xattr_name: requested xattr
> + * @xattr_value: requested xattr value
> + * @xattr_value_len: requested xattr value length
> + *
> + * Check if passed xattr value differs from current value.
> + *
> + * Returns 1 if passed xattr value differs from current value, 0 otherwise.
> + */
> +static int evm_xattr_change(struct dentry *dentry, const char *xattr_name,
> +			    const void *xattr_value, size_t xattr_value_len)
> +{
> +	char *xattr_data = NULL;
> +	int rc = 0;
> +
> +	if (posix_xattr_acl(xattr_name))
> +		return evm_xattr_acl_change(dentry, xattr_name, xattr_value,
> +					    xattr_value_len);
> +
> +	rc = vfs_getxattr_alloc(dentry, xattr_name, &xattr_data, 0, GFP_NOFS);
> +	if (rc < 0)
> +		return 1;
> +
> +	if (rc == xattr_value_len)
> +		rc = memcmp(xattr_value, xattr_data, rc);

This should probably be changed to crypto_memneq().   Refer to commit
613317bd212c ("EVM: Use crypto_memneq() for digest comparisons").

thanks,

Mimi

> +	else
> +		rc = 1;
> +
> +	kfree(xattr_data);
> +	return rc;
> +}
> +
> 

