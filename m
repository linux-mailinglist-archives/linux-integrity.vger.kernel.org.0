Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAE73AE9F9
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jun 2021 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFUN2K (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Jun 2021 09:28:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49788 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229708AbhFUN2J (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jun 2021 09:28:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LD40dU034007;
        Mon, 21 Jun 2021 09:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=hqFx3xpS6aZ8X/y5N6zKbrcRBhuvPaEnZk+43JmXGQg=;
 b=c08qRUidjPVVkF3rA0OgQOHkTSOLo2rWmIHYkwJjzMUT4s9m5rHjWWlcRGiCZ3HMRN4u
 PItFaQUPN02VUru4ZFhFv1UqeOVLj1Z/eOmOpdpZTNsXPNvd8GgOxnFZ0Cw3c2g7oSol
 q+A/mPhozVeRL/R4Le3OxxPuPzsEXVWuDOR/yh35MCGx32n7LakHv0w0xpV3qqdmj0is
 7rFSBj9G17QFowCl6/HgjkMMQgJcktwpk8FXHSp1H9h+cWFiagEmbsgZHFoNDOCPdzwP
 DV/MgEAPJbq7dZEHMN8LcJ2842Zm3joQOrWFAxOtOpVDBFve1Q5Ntg1sUPQ4KCpJE2ST aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39at103j23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 09:25:50 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15LD4uN7040446;
        Mon, 21 Jun 2021 09:25:49 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39at103hy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 09:25:49 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15LD76lI004957;
        Mon, 21 Jun 2021 13:25:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3998788wun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 13:25:45 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15LDPhTA23920928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 13:25:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B115A4040;
        Mon, 21 Jun 2021 13:25:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25166A4055;
        Mon, 21 Jun 2021 13:25:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.107.100])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jun 2021 13:25:40 +0000 (GMT)
Message-ID: <46ce17543ea05839467fab8865826a0492e8632b.camel@linux.ibm.com>
Subject: Re: [PATCH v2] evm: Check xattr size discrepancy between kernel and
 user
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        stefanb@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Date:   Mon, 21 Jun 2021 09:25:40 -0400
In-Reply-To: <20210621122912.1472470-1-roberto.sassu@huawei.com>
References: <20210621122912.1472470-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gozS-3LOno6sEm8WACG_HJ6wV4y_7m1U
X-Proofpoint-GUID: YVs83M9VRHzuHxTHHIXgjLXdPa8FQMCR
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_06:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106210078
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-06-21 at 14:29 +0200, Roberto Sassu wrote:
> The kernel and the user obtain an xattr value in two different ways:
> 
> kernel (EVM): uses vfs_getxattr_alloc() which obtains the xattr value from
>               the filesystem handler (raw value);
> 
> user (ima-evm-utils): uses vfs_getxattr() which obtains the xattr value
>                       from the LSMs (normalized value).
> 
> Normally, this does not have an impact unless security.selinux is set with
> setfattr, with a value not terminated by '\0' (this is not the recommended
> way, security.selinux should be set with the appropriate tools such as
> chcon and restorecon).
> 
> In this case, the kernel and the user see two different xattr values: the
> former sees the xattr value without '\0' (raw value), the latter sees the
> value with '\0' (value normalized by SELinux).
> 
> This could result in two different verification outcomes from EVM and
> ima-evm-utils, if a signature was calculated with a security.selinux value
> terminated by '\0' and the value set in the filesystem is not terminated by
> '\0'. The former would report verification failure due to the missing '\0',
> while the latter would report verification success (because it gets the
> normalized value with '\0').
> 
> This patch mitigates this issue by comparing in evm_calc_hmac_or_hash() the
> size of the xattr returned by the two xattr functions and by warning the
> user if there is a discrepancy.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, Roberto.

Applied to: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git next-integrity-testing branch.

Mimi

