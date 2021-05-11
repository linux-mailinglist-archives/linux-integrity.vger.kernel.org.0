Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0521E37A7EB
	for <lists+linux-integrity@lfdr.de>; Tue, 11 May 2021 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhEKNn0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 09:43:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229921AbhEKNnZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 09:43:25 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BDXqFs140950;
        Tue, 11 May 2021 09:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MERjTyE1EK7mO/pouLX4TafCiBzrd/VTQGESRGYunAQ=;
 b=Q1C1kU5n8cbGvEnejOmNkRWoYsgNAaZDnIw/SRj+hRsX89tIXWMgmDKn1zJpN+nOYr8l
 eIzJxYbevINVXbMtr/h6kdZ1Uwisys8qpDQ+IB6MRji0dT1I61a8GZqLfypZL0q1GITD
 qwNIoDxAuYhjRGE6wjvqa3BlGKIgp0217tqqJQC5qyD/nTdVfARYjHBwh2/Q/X0P/G2Y
 fGLm5RaxCt95ezvN+cAwh760AifYH1qqIHL+Q1wYGkk+hZqQkB/Qftejc4EpVtNboWwN
 RFWvjPrSUuwzHEjeRlBJxja8fWfhWV9KMAb+MN/HBNnb8KqUIVjw3x5Ksk/33Z3UVUVT eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fqrf6m6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 09:42:16 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14BDYAZo142244;
        Tue, 11 May 2021 09:42:16 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fqrf6m58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 09:42:16 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BDgD80012422;
        Tue, 11 May 2021 13:42:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 38dhwh9q18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 13:42:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BDfhnA30867768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 13:41:44 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 706E64204B;
        Tue, 11 May 2021 13:42:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93BBA4203F;
        Tue, 11 May 2021 13:42:09 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.76])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 13:42:09 +0000 (GMT)
Message-ID: <a0657cec664efcedb3d2501ac10e7365fd196e77.camel@linux.ibm.com>
Subject: Re: [PATCH v6 04/11] evm: Introduce evm_status_revalidate()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 May 2021 09:42:08 -0400
In-Reply-To: <20210505112935.1410679-5-roberto.sassu@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
         <20210505112935.1410679-5-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vfLP_Npy8MhnUOz0LL8EFF5Vrx7aujxp
X-Proofpoint-GUID: _dmIjX4yv3mC9VW6wl9BdsCnWifXEtnR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_02:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=736 clxscore=1015 suspectscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-05-05 at 13:29 +0200, Roberto Sassu wrote:
> When EVM_ALLOW_METADATA_WRITES is set, EVM allows any operation on
> metadata. Its main purpose is to allow users to freely set metadata when it
> is protected by a portable signature, until an HMAC key is loaded.
> 
> However, callers of evm_verifyxattr() are not notified about metadata
> changes and continue to rely on the last status returned by the function.
> For example IMA, since it caches the appraisal result, will not call again
> evm_verifyxattr() until the appraisal flags are cleared, and will grant
> access to the file even if there was a metadata operation that made the
> portable signature invalid.
> 
> This patch introduces evm_status_revalidate(), which callers of
> evm_verifyxattr() can use in their xattr hooks to determine whether
> re-validation is necessary and to do the proper actions. IMA calls it in
> its xattr hooks to reset the appraisal flags, so that the EVM status is
> re-evaluated after a metadata operation.
> 
> Lastly, this patch also adds a call to evm_reset_status() in
> evm_inode_post_setattr() to invalidate the cached EVM status after a
> setattr operation.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

I'm really  sorry for the patch churn, but could you rename
evm_status_revalidate() to evm_revalidate_status().

Otherwise,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

thanks,

Mimi

