Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5310737A7F0
	for <lists+linux-integrity@lfdr.de>; Tue, 11 May 2021 15:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhEKNnf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 09:43:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231623AbhEKNne (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 09:43:34 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BDYP3X009593;
        Tue, 11 May 2021 09:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=f9vO9RefB+oUE3iXwZ90+gEsfMSU8YiKItNlbfwzQus=;
 b=a7S3v/ZkYvVr7PIvaZMea7V0MB5uhuZC28n31LfFwLL4CiEBbnNn570YG8wT7TgkYUsZ
 34jhs5U3I+vrk/4Etla71ylsYs5uQAGp2fHIoBp/KLegDSZyWiNLv0ERO8AmcJsyyE/K
 7KdgU3Z7D6fueKe6AsY8PVkSs8LdZb+LdPQ+2e087gv22jrmByg53uuYqxHidCj5GKZw
 TVyi5P9Ege/1VJ6U+FIPNpLnNiXLiiXUDG5tvJie8za0X/aSwmrK0ufj26Ff5DQbRxyd
 dQm1skG8rQmvlH8WkHaDh+FwhqmA1MCZ1hn6AzQd189zphUy6uJg0pbagIcoqwCN8FdS pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fsrvttc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 09:42:22 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14BDb0pn020296;
        Tue, 11 May 2021 09:42:21 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38fsrvttbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 09:42:21 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BDfve1023047;
        Tue, 11 May 2021 13:42:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 38dj989pxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 13:42:19 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BDgH1D63570222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:42:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA9A611C052;
        Tue, 11 May 2021 13:42:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7241711C04C;
        Tue, 11 May 2021 13:42:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.76])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 13:42:16 +0000 (GMT)
Message-ID: <956020eb1babea38fa904aadfdbc4c81b9fb7baa.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH v6 05/11] evm: Introduce evm_hmac_disabled() to
 safely ignore verification errors
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 May 2021 09:42:15 -0400
In-Reply-To: <20210507133114.2138653-1-roberto.sassu@huawei.com>
References: <20210505113329.1410943-1-roberto.sassu@huawei.com>
         <20210507133114.2138653-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qDkpqTL3z5NsS3aQuUgasGcRbsgbs9kP
X-Proofpoint-GUID: t1GGushV9RgWfXjWKUFDQ8VKgfhyIstr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-05-07 at 15:31 +0200, Roberto Sassu wrote:
> When a file is being created, LSMs can set the initial label with the
> inode_init_security hook. If no HMAC key is loaded, the new file will have
> LSM xattrs but not the HMAC. It is also possible that the file remains
> without protected xattrs after creation if no active LSM provided it.
> 
> Unfortunately, EVM will deny any further metadata operation on new files,
> as evm_protect_xattr() will always return the INTEGRITY_NOLABEL error, or
> INTEGRITY_NOXATTRS if no protected xattrs exist. This would limit the
> usability of EVM when only a public key is loaded, as commands such as cp
> or tar with the option to preserve xattrs won't work.
> 
> This patch introduces the evm_hmac_disabled() function to determine whether
> or not it is safe to ignore verification errors, based on the ability of
> EVM to calculate HMACs. If the HMAC key is not loaded, and it cannot be
> loaded in the future due to the EVM_SETUP_COMPLETE initialization flag,
> allowing an operation despite the attrs/xattrs being found invalid will not
> make them valid.
> 
> Since the post hooks can be executed even when the HMAC key is not loaded,
> this patch also ensures that the EVM_INIT_HMAC initialization flag is set
> before the post hooks call evm_update_evmxattr().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

Thanks, Robert!

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

