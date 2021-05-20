Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545A838B65D
	for <lists+linux-integrity@lfdr.de>; Thu, 20 May 2021 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbhETS5U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 May 2021 14:57:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236298AbhETS5S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 May 2021 14:57:18 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14KIXa5g114847;
        Thu, 20 May 2021 14:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=/FWeYLLzKYJq+Mn97bIeKsGmP2E4KLkapDfWGqktG18=;
 b=Pab8dH6G7l8SVfh6jGE9A2ahAx5ob9nqvQO/Z14gj8NhSG0qrZUthU4Md1m0g48H9NIZ
 SnYmUcFFGDHHl6wh2XmLlBTAi0cjLwQMPrVyYm03QafNH9HbvED5WEmjHG6lXNiMXrL0
 0X3+Ux/L8/vPjb/ZCZ30YUB4+wv0CL/7NBajn1L2rdt5IxFbbv3k3WBcONjbIMNoipLK
 vggEwdoB0ko8wooklIiS51o9gluplX4F2Ec4gd4g3L7Sn2doo1g+ltcm4TpxlOfm4Nqv
 2Sc9Czszb9F15zLPwNzXrj4+fWWLcY7f5BEZGXr3WDc/H+KRswJ8IJNDX5PJLNB/cRnA WA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38nvg3hxxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 14:55:50 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14KInA5B007814;
        Thu, 20 May 2021 18:55:48 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 38j5jgtskc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 May 2021 18:55:48 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14KItkXG32506296
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 18:55:46 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 385A211C05B;
        Thu, 20 May 2021 18:55:46 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FC8911C054;
        Thu, 20 May 2021 18:55:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.39.138])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 May 2021 18:55:44 +0000 (GMT)
Message-ID: <2804f10fa77b58b4992f56ea36a36d4f1e3f4b24.camel@linux.ibm.com>
Subject: Re: [PATCH v7 00/12] evm: Improve usability of portable signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@srcf.ucam.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 May 2021 14:55:41 -0400
In-Reply-To: <20210514152753.982958-1-roberto.sassu@huawei.com>
References: <20210514152753.982958-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iLxvC9fF25kogA-DMlJ7ffq-1ywJmKXX
X-Proofpoint-ORIG-GUID: iLxvC9fF25kogA-DMlJ7ffq-1ywJmKXX
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-20_05:2021-05-20,2021-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 mlxscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200112
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-05-14 at 17:27 +0200, Roberto Sassu wrote:
> EVM portable signatures are particularly suitable for the protection of
> metadata of immutable files where metadata is signed by a software vendor.
> They can be used for example in conjunction with an IMA policy that
> appraises only executed and memory mapped files.
> 
> However, until now portable signatures can be properly installed only if
> the EVM_ALLOW_METADATA_WRITES initialization flag is also set, which
> disables metadata verification until an HMAC key is loaded. This will cause
> metadata writes to be allowed even in the situations where they shouldn't
> (metadata protected by a portable signature is immutable).
> 
> The main reason why setting the flag is necessary is that the operations
> necessary to install portable signatures and protected metadata would be
> otherwise denied, despite being legitimate, due to the fact that the
> decision logic has to avoid an unsafe recalculation of the HMAC that would
> make the unsuccessfully verified metadata valid. However, the decision
> logic is too coarse, and does not fully take into account all the possible
> situations where metadata operations could be allowed.
> 
> For example, if the HMAC key is not loaded and it cannot be loaded in the
> future due the EVM_SETUP_COMPLETE flag being set, it wouldn't be a problem
> to allow metadata operations, as they wouldn't result in an HMAC being
> recalculated.
> 
> This patch set extends the decision logic and adds the necessary exceptions
> to use portable signatures without turning off metadata verification and
> deprecates the EVM_ALLOW_METADATA_WRITES flag.

Thanks, Roberto.

Applied to: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git 
next-integrity-testing

Mimi


