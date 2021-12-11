Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9F4714A5
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 17:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhLKQGJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 11:06:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231434AbhLKQGH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 11:06:07 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BBFb9Yv025425;
        Sat, 11 Dec 2021 16:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=1XXbvveYfvXi++N89zqRKU1Xxu7eymV07uURoT3M2MY=;
 b=eeTeEoEjE4RmcFoN1jIu6Zl9yz5+EFafOyAZu65rSj6kmWph0p8TSJk4NrYunUm4PVvi
 KALJZwR65sbdUXg4Iruqg4v9k2jXi8EGl8dRRfqgWUp0It7lb7WRvE4acMSl59Ck4HjS
 utFBzgcnCQcHH5Z2L4R5M83YVSEi+SKFLdFlvt+3f1rINahaPuytcDqoE2iC70qBi3Re
 L/nEjEFpK5dwElX+6WBHdNT/kVHO9No/bByJwCza033yOgKi5ssXa57HrNupuCdPLFne
 j5pjGMEZUqFfGwUaF2o1NxnCqWROQhUdo+2rA0csz4IVlcGljaF5NSTAO51wWsP92ntW bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvx758ncb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 16:05:52 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BBG5qH9005986;
        Sat, 11 Dec 2021 16:05:52 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cvx758nc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 16:05:52 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BBFwCsW009197;
        Sat, 11 Dec 2021 16:00:50 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01dal.us.ibm.com with ESMTP id 3cvkm97ghm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 Dec 2021 16:00:50 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BBG0mnH23724384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Dec 2021 16:00:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DC5B78064;
        Sat, 11 Dec 2021 16:00:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66E097805C;
        Sat, 11 Dec 2021 16:00:44 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.97.102])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sat, 11 Dec 2021 16:00:44 +0000 (GMT)
Message-ID: <985818fabf3ed1478fd53cb4dd48162fff132492.camel@linux.ibm.com>
Subject: Re: [PATCH v5 14/16] ima: Use mac_admin_ns_capable() to check
 corresponding capability
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Stefan Berger <stefanb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Denis Semakin <denis.semakin@huawei.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
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
Date:   Sat, 11 Dec 2021 11:00:42 -0500
In-Reply-To: <7a914d80-db7c-cdd9-358a-97138ec6d750@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
         <20211208221818.1519628-15-stefanb@linux.ibm.com>
         <cde301002f884f43bcb7fa244b1c6b84@huawei.com>
         <20211211150246.GA24925@mail.hallyn.com>
         <7a914d80-db7c-cdd9-358a-97138ec6d750@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: o459A8-V-MKQ8h-Jjslc0tWQlDlM3ToD
X-Proofpoint-GUID: Q8ye0QYaN66eI64W3uABy1ge0cp1o9WC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-11_06,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112110089
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-12-11 at 10:38 -0500, Stefan Berger wrote:
> On 12/11/21 10:02, Serge E. Hallyn wrote:
> > IMO yes it is unsafe, however I concede that I am not sufficiently
> > familiar with the policy language.  At least Stefan and Mimi (IIUC)
> > want the host policy language to be able to specify cases where an
> > IMA ns can be configured.  What's not clear to me is what sorts of
> > triggers the host IMA policy could specify that would safely
> > identify a IMA ns generation
> > trigger.
> > 
> > Stefan, would you mind showing what such a policy statement would
> > look like? Does it amount to "/usr/bin/runc may create an IMA ns
> > which escapes current policy" ?  Or is it by UID, or any file which
> > has a certain xattr on it?
> 
> If this policy here is active on the host then file executions 
> (BPRM_CHECK) of uid=0 should be measured and audited on the host in
> any IMA namespace that uid=0 may create. We achieve this with
> hierarchical processing (v6: 10/17).
> 
> measure func=BPRM_CHECK mask=MAY_EXEC uid=0
> 
> audit func=BPRM_CHECK mask=MAY_EXEC uid=0

Or perhaps to put another way that might be more useful to unprivileged
containers: if you strip the uid=0 from both of those statements, you
get a rule that logs and audits any execution.  Once you enter the IMA
namespace, in that namespace you see nothing, but outside the parent is
still logging and auditing all executions, including those inside the
container, according to its measure/audit all executions rule.  The
container can't turn that off by writes to its policy file.

So the container can never escape any policy rule imposed by the parent

James


