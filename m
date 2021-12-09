Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C58446E915
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 14:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbhLIN1f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 08:27:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237913AbhLIN1e (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 08:27:34 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9CTIYF001755;
        Thu, 9 Dec 2021 13:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : content-transfer-encoding : mime-version; s=pp1;
 bh=Peb/1+zlJfUFXCByvdrVxxZHXcbEVfe/h5BLXGK8cfU=;
 b=TZu4JI3e+xJjXvuO6TdMssLpPULlJfSh8gKiMp9lj2jqu8/n6VVwXlRABqo8mUdXnKkM
 FvS9YAizUPouMCUS1UcKMNs1PTjHWQZ8loPFJoMJHovh+QOfal60A0pUVvndpBCUa8i0
 0ApzNGyJIaF35dVUzyl4gJG3TobY5xZoeWOAmwhsn+WVzdClwrq8hM4dns3KCrBzq1xO
 aFqkrLQpM/ZAgf/RjmeJdoNq6Ea6P44eONkDUzgM9Qq2YZdt3stFX82yrQ1CKywedwQG
 eLUml95hQ9b97uNGGj1ofIvz8cm87gZA8QzPpruGVI/mB7YYVjP7SjSbtBqypdLYLw04 /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cuhuch5ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 13:23:45 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B9CV3pe009524;
        Thu, 9 Dec 2021 13:23:44 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cuhuch5ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 13:23:44 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DIDgO031552;
        Thu, 9 Dec 2021 13:23:43 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3cqyyc6u9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 13:23:43 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B9DNfBX43843924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 13:23:41 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2208478068;
        Thu,  9 Dec 2021 13:23:41 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CD6978067;
        Thu,  9 Dec 2021 13:23:37 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.77.2])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Dec 2021 13:23:36 +0000 (GMT)
Message-ID: <e285cfdc3f6380c7ca5f6e22378ba8343bedf622.camel@linux.ibm.com>
Subject: Re: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check
 corresponding capability
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Denis Semakin <denis.semakin@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "containers@lists.linux.dev" <containers@lists.linux.dev>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "mpeters@redhat.com" <mpeters@redhat.com>,
        "lhinds@redhat.com" <lhinds@redhat.com>,
        "lsturman@redhat.com" <lsturman@redhat.com>,
        "puiterwi@redhat.com" <puiterwi@redhat.com>,
        "jamjoom@us.ibm.com" <jamjoom@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "rgb@redhat.com" <rgb@redhat.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>
Date:   Thu, 09 Dec 2021 08:23:35 -0500
In-Reply-To: <0299fefc764b453a9449b0df2ca06dc7@huawei.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-15-stefanb@linux.ibm.com>
         <0299fefc764b453a9449b0df2ca06dc7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R8r8z7DhB-xEleZFpzp9M3XvfZJ9a0Ll
X-Proofpoint-ORIG-GUID: u46tJdfnkoEbFj8j50kxjEePKVoTFNlO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_04,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-12-09 at 07:22 +0000, Denis Semakin wrote:
> Hi. 
> My question won't be about capabilities. I'm wondering how IMA-ns
> which is associated with USER-ns and is created during USER-ns
> creation would be used by some namespaces orchestration systems, e.g.
> Kubernetes?

Orchestration systems that don't adopt the user namespace can't really
run containers requiring admin correctly without giving them root minus
some capabilities, which is rather unsafe, so the expectation is that
they'll all figure it out eventually for security reasons.

> .. It seems that it can be run without any user namespaces... 
> Their community just discuss this opportunity to support User
> namespaces. (see https://github.com/kubernetes/enhancements/pull/2101
> ) Looks like currently IMA-ns will not be applicable for Kubernetes.

Well, lets just say it adds one more reason to get kubernetes to
finally run rootless privileged containers correctly ...

James


