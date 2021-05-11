Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9A37AFCC
	for <lists+linux-integrity@lfdr.de>; Tue, 11 May 2021 22:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhEKUBu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 16:01:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60938 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229456AbhEKUBu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 16:01:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BJXtF6171602;
        Tue, 11 May 2021 16:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=njbu/C3s6O9b4Ysx27CFBNm0SZhkA/5t7mL8wpcRUbo=;
 b=QWpP9GxTfBJdHiQTYmhtc+xM5cuK7uutbV4QD40eDheeH6AiBZJbf37ltlik/Bf1whyT
 Yk7iv5mz5CpJsUR4yRgYDoGztcZMGYcKXF7yj9cTnhnPOe7f2D77h7PGrSjSj61mDd84
 U/AEi7ZI/GYM5yRLcsWxuqUNEgWRwZV6K01oVIisJll6uNjatXyEblPNJOzBt8S4zHxK
 PfJx8hqkUYMSj93tr6SWZpKKYNhqEeaGgsY9DnTfUMXsaoXcoaE2fOdqN1ZDo/ZOjvwC
 K0URZ1VJOp7QuJEVxjl0vCLqfWyf3RvOBEf/7psIHUpwdjjDNT9FmcfvTseJsGWfI1Xf QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fw0r6ehs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 16:00:38 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 14BJYinq180858;
        Tue, 11 May 2021 16:00:37 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fw0r6egk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 16:00:37 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BJx8F6030797;
        Tue, 11 May 2021 20:00:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 38ef37gsvc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 20:00:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BK0WRv19988748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 20:00:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A78FE4C058;
        Tue, 11 May 2021 20:00:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE0D14C04A;
        Tue, 11 May 2021 20:00:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.116.76])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 20:00:30 +0000 (GMT)
Message-ID: <234ccd701bec53b979015fdd257e48400cd68759.camel@linux.ibm.com>
Subject: Re: [PATCH v6 08/11] evm: Allow setxattr() and setattr() for
 unmodified metadata
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        "mjg59@google.com" <mjg59@google.com>
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        kernel test robot <lkp@intel.com>
Date:   Tue, 11 May 2021 16:00:29 -0400
In-Reply-To: <0d0fcd3619e64bb9aaf1656ef066d043@huawei.com>
References: <20210505112935.1410679-1-roberto.sassu@huawei.com>
         <20210505113329.1410943-4-roberto.sassu@huawei.com>
         <735bae46f0772b40ef6ecfb3c6fe0267b3ebbee8.camel@linux.ibm.com>
         <c281b39bdbaa4b5ab921a2e9cece83b4@huawei.com>
         <1a5d2a37be31f7971374c01ed8e799e003c96f9d.camel@linux.ibm.com>
         <0d0fcd3619e64bb9aaf1656ef066d043@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xQ9f_TNIoozkP6KuiEXuHVtaPKH72WOP
X-Proofpoint-GUID: 3Iff-qCDN2QxHlWyaztxD_e1zbBfmc81
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 mlxlogscore=999 impostorscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105110130
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-05-11 at 14:54 +0000, Roberto Sassu wrote:
> > On Tue, 2021-05-11 at 14:21 +0000, Roberto Sassu wrote:
> > > >
> > > > On Wed, 2021-05-05 at 13:33 +0200, Roberto Sassu wrote:
> > > > > With the patch to allow xattr/attr operations if a portable signature
> > > > > verification fails, cp and tar can copy all xattrs/attrs so that at the
> > > > > end of the process verification succeeds.
> > > > >
> > > > > However, it might happen that the xattrs/attrs are already set to the
> > > > > correct value (taken at signing time) and signature verification succeeds
> > > > > before the copy has completed. For example, an archive might contains
> > files
> > > > > owned by root and the archive is extracted by root.
> > > > >
> > > > > Then, since portable signatures are immutable, all subsequent operations
> > > > > fail (e.g. fchown()), even if the operation is legitimate (does not alter
> > > > > the current value).
> > > > >
> > > > > This patch avoids this problem by reporting successful operation to user
> > > > > space when that operation does not alter the current value of
> > xattrs/attrs.
> > > >
> > > > I must be missing something.  If both the IMA and EVM status flags are
> > > > reset after xattr or attr modification, do we really need to prevent
> > > > any metadata - same or different - changes?  Both evm_protect_xattr()
> > > > and evm_inode_setattr() would need to be modified to allow
> > > > INTEGRITY_PASS_IMMUTABLE.
> > >
> > > yes, given that the IMA and EVM flags are reset, it should not be
> > > a problem to allow changes. However, I think it is useful to keep
> > > the current behavior. For example, it would prevent an accidental
> > > change of the SELinux label during the relabeling process.
> > 
> > I understand we might want to prevent accidental or malicious changes,
> > but that isn't the purpose of this patch set.  The patch description
> > would also need to be updated to reflect the real purpose.
> 
> We would be changing the expectation that metadata changes
> are denied, which was defined with the original patches.
> 
> I would prefer to keep the current behavior, but if your suggestion
> is to allow metadata changes, I will modify the patch set.

Please re-write the patch description appropriately.

thanks,

Mimi

