Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC6C3AE901
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jun 2021 14:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhFUMYw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Jun 2021 08:24:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7424 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229623AbhFUMYv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Jun 2021 08:24:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15LC4NTl052750;
        Mon, 21 Jun 2021 08:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=IYERda7V9jupEutV03ty9nGHGJaU/FjhK4q2mqcW/nk=;
 b=MgTTupRBljhMWIG7g6hsrosN/yn7I5rApcFPMOsZ9WYsK15hMWbx3h4xIGJC0AJF/GA+
 b6hnm/+I4mMT9zjqE9lI4Tk+J7uhxkkfWc0SxCoWnBg5+WXdVqfb/BxsfUalhOQCZUXT
 XQ3quk4qG3lQIVhdgAGZt96DFySC60l30Zyzs6EipoLm7FJfRSi3FD6NxOx33hAIBgEO
 UGw5PB/mU769wHCSBmk/SYEDXw/GPv4c1+32ctMmel3erzFCeK9FYDXt1qyqXBLV2Q7y
 6/MD/Gu5dCU17dc3r6rxTIsy0c4pft6eBDfzbZRskfFDpofwAPXzWzapNqngCR53qC8Z zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39atbxgs4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 08:22:25 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15LC6TmD069897;
        Mon, 21 Jun 2021 08:22:25 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39atbxgs40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 08:22:25 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15LCDE8r019771;
        Mon, 21 Jun 2021 12:22:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3998788g25-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 12:22:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15LCMKBG16974082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Jun 2021 12:22:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BADFE42049;
        Mon, 21 Jun 2021 12:22:20 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7A9E42045;
        Mon, 21 Jun 2021 12:22:18 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.107.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Jun 2021 12:22:18 +0000 (GMT)
Message-ID: <073e829709dcbfb19244b1b1df2c39461297f337.camel@linux.ibm.com>
Subject: Re: [PATCH] evm: Check xattr size misalignment between kernel and
 user
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        stefanb@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Date:   Mon, 21 Jun 2021 08:22:17 -0400
In-Reply-To: <20210621093923.1456675-1-roberto.sassu@huawei.com>
References: <20210621093923.1456675-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LWDLUyTVs_Qs2YEhYrKeYB2iivM6QOQX
X-Proofpoint-ORIG-GUID: EzZM2YeLBFkhysI5Xpsv8iDCVisCwiRL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_05:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106210072
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-06-21 at 11:39 +0200, Roberto Sassu wrote:
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
> user if there is a misalignment.

Instead of "misalignment" how about using the word "discrepancy" here
and in the Subject line?

> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

Otherwise, 
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

