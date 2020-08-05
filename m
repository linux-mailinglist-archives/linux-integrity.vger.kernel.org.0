Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CB423CCEC
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgHERLg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 13:11:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32478 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728489AbgHERIi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 13:08:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075CWW3e113416;
        Wed, 5 Aug 2020 08:38:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qrr1qq47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 08:38:08 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 075CWeu2113976;
        Wed, 5 Aug 2020 08:38:07 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qrr1qq35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 08:38:07 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075CZkxk021961;
        Wed, 5 Aug 2020 12:38:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 32n018amv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 12:38:04 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075Cc2Pk20775184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 12:38:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ED954C058;
        Wed,  5 Aug 2020 12:38:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37B504C046;
        Wed,  5 Aug 2020 12:38:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.205])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 12:37:59 +0000 (GMT)
Message-ID: <3a96065c7c628be36eba99ad0da8d78cdac7dcaf.camel@linux.ibm.com>
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        stephen.smalley.work@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 08:37:59 -0400
In-Reply-To: <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
         <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_09:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050102
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-08-04 at 18:04 -0700, Casey Schaufler wrote:
> On 8/4/2020 5:43 PM, Lakshmi Ramasubramanian wrote:
> > Critical data structures of security modules are currently not measured.
> > Therefore an attestation service, for instance, would not be able to
> > attest whether the security modules are always operating with the policies
> > and configuration that the system administrator had setup. The policies
> > and configuration for the security modules could be tampered with by
> > malware by exploiting kernel vulnerabilities or modified through some
> > inadvertent actions on the system. Measuring such critical data would
> > enable an attestation service to better assess the state of the system.
> 
> I still wonder why you're calling this an LSM change/feature when
> all the change is in IMA and SELinux. You're not putting anything
> into the LSM infrastructure, not are you using the LSM infrastructure
> to achieve your ends. Sure, you *could* support other security modules
> using this scheme, but you have a configuration dependency on
> SELinux, so that's at best going to be messy. If you want this to
> be an LSM "feature" you need to use the LSM hooking mechanism.
> 
> I'm not objecting to the feature. It adds value. But as you've
> implemented it it is either an IMA extension to SELinux, or an
> SELiux extension to IMA. Could AppArmor add hooks for this without
> changing the IMA code? It doesn't look like it to me.

Agreed.  Without reviewing the patch set in depth, I'm not quite sure
why this patch set needs to be limited to measuring just LSM critical
data and can't be generalized.    The patch set could be titled "ima:
measuring critical data" or "ima: measuring critical kernel data". 
Measuring SELinux critical data would be an example of its usage.

For an example, refer to the ima_file_check hook, which is an example
of IMA being called directly, not via an LSM hook.

Mimi

