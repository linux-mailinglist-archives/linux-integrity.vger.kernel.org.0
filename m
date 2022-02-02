Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EFA4A755C
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 17:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiBBQEo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 11:04:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56944 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234360AbiBBQEn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 11:04:43 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212E69Ya027428;
        Wed, 2 Feb 2022 16:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9NuijRvVfCgStj+uKowStpwOkLQEsf6EhU5eLkUU6OA=;
 b=OHym0JjeGRuTKCGsWsrOr5/H3b6oqFMcIpgqc04U3jWFcLaPZ/bxbfVJ5V2BJHjCId7i
 /iCXncWbDnLPatARBVqqoLcnbV8a/eOr4X6QBMtk+Qvf4joiyE4YzKLTvJCpYU5uc188
 FK+v3w0AVO6jYZfSl8HxzMegiDP2WK7hmNulIaCP1vTtzNxwZIB7wds8/9r91u78Pq+Y
 kaTgdVpablsYT6/feSeLxw9sQV5pCbJytOpNJbreCMd5LQcwxr6POIFEYluM6daBSHcE
 L+6os1MryiV4aD9HCszwSJ9QHasomBB6chrLLqIK/Vs4fFJH2/U9RTnMXuAVJAxE14mi zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyt7x4ekp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 16:04:29 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212E83Iv039656;
        Wed, 2 Feb 2022 16:04:28 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyt7x4ejw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 16:04:28 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212FwRp9004873;
        Wed, 2 Feb 2022 16:04:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3dvvujpt61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 16:04:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212G4LvH46072136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 16:04:21 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37CAA4C059;
        Wed,  2 Feb 2022 16:04:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFC5A4C04E;
        Wed,  2 Feb 2022 16:04:18 +0000 (GMT)
Received: from sig-9-65-79-154.ibm.com (unknown [9.65.79.154])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 16:04:18 +0000 (GMT)
Message-ID: <d08ffbb2f803cd26f4d9697868e138cdb2e71d32.camel@linux.ibm.com>
Subject: Re: [PATCH v10 00/27] ima: Namespace IMA with audit support in
 IMA-ns
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Wed, 02 Feb 2022 11:04:18 -0500
In-Reply-To: <3f053d38-00f7-b495-4ea2-3c61fa120284@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220202141329.k5jcsbutpmzv53c3@wittgenstein>
         <3f053d38-00f7-b495-4ea2-3c61fa120284@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A8p0VPUdxKCS_mcla4NjbftohdTcgfzG
X-Proofpoint-GUID: orZpxAzCsBDWXKObK5I93ubI0xiQrtQk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_07,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202020090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-02-02 at 09:40 -0500, Stefan Berger wrote:
> On 2/2/22 09:13, Christian Brauner wrote:
> > On Tue, Feb 01, 2022 at 03:37:08PM -0500, Stefan Berger wrote:
> >>
> >> v10:
> >>   - Added A-b's; addressed issues from v9
> >>   - Added 2 patches to support freeing of iint after namespace deletion
> >>   - Added patch to return error code from securityfs functions
> >>   - Added patch to limit number of policy rules in IMA-ns to 1024
> > I'm going to go take a lighter touch with this round of reviews.
> > First, because I have February off. :)
> > Second, because I think that someone who is more familiar with IMA and
> > its requirements should take another look to provide input and ask more
> > questions. Last time I spoke to Serge he did want to give this a longer
> > look and maybe also has additional questions.
> 
> The one problem I am seeing is that we probably cannot support auditing 
> in IMA namespaces since every user can now create an IMA namespace. 
> Unless auditing was namespaced, the way it is now gives too much control 
> to the user to flood the host audit log.

Stefan, we need to differentiate between the different types of audit
records being produced by IMA.  Some of these are informational, like
the policy rules being loaded or "Time of Measure, Time of Use"
(ToMToU) records.  When we discuss IMA-audit we're referring to the
file hashes being added in the audit log.  These are the result of the
IMA "audit" policy rules.

How much of these informational messages should be audited in IMA
namespaces still needs to be discussed.  For now, feel free to limit
the audit messages to just the file hashes.

thanks,

Mimi

