Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93B255909
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 13:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgH1LCh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 07:02:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728444AbgH1LAZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 07:00:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07SAWjaY109078;
        Fri, 28 Aug 2020 06:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=UjEwjgQre7DBftpvnsrN+R8Bd55CfmO1UEnvz8w2eII=;
 b=Hv4r/YZprUHzTB7MY9LD9gU/BHO+e22umJWMvG2UffgD86CbRXI1ny+QQLPhxtXMePcZ
 GUPM1n6ySNbmKgFWPtymCPGYpoOngjt7+tEu+4NMKO8hhLrEo5n7TYH6UJY0n26cZZeI
 ISUv9h1s6tw85BOA8M1pj4yXyuW7qcYFV7/VJIaQwJf8yNPUt7LSJZies1JsjqjjOvNy
 nQ9s8yjMY79AVVE0Qbfah0Vb/XbJwZQxbLK8WirpgQDn1cxxvI7VlNNPOJMaZ2J2Nexw
 csApApHpJpik3mGXXNcvR4S6YqXuSvcLZvNUuj6kx42wbzARZgZMFTvwMssv2vnlUYP+ pg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336xtv329a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 06:59:51 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07SAlIOW020024;
        Fri, 28 Aug 2020 10:59:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 332utq43j3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 10:59:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07SAxkiZ19136934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 10:59:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCC7E42042;
        Fri, 28 Aug 2020 10:59:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D25BD4203F;
        Fri, 28 Aug 2020 10:59:45 +0000 (GMT)
Received: from sig-9-65-214-13.ibm.com (unknown [9.65.214.13])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Aug 2020 10:59:45 +0000 (GMT)
Message-ID: <59586987f6050a0cb5b744284895373b7c8232dd.camel@linux.ibm.com>
Subject: Re: [LTP v4 4/5] IMA: Add a test to verify measurement of
 certificate imported into a keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Date:   Fri, 28 Aug 2020 06:59:45 -0400
In-Reply-To: <20200820090824.3033-5-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
         <20200820090824.3033-5-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_06:2020-08-28,2020-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=3 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=697 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280078
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-08-20 at 11:08 +0200, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> The IMA subsystem supports measuring certificates that have been
> imported into either system built-in or user-defined keyrings.
> A test to verify measurement of a certificate imported
> into a keyring is required.
> 
> Add an IMA measurement test that verifies that an x509 certificate
> can be imported into a newly-created, user-defined keyring and measured
> correctly by the IMA subsystem.
> 
> A certificate used by the test is included in the `datafiles/keys`
> directory.
> 
> There can be restrictions on importing a certificate into a builtin
> trusted keyring. For example, the `.ima` keyring requires that
> imported certs be signed by a kernel private key in certain
> kernel configurations. For this reason, this test defines
> a user-defined keyring and imports a certificate into that.

FYI, similar restrictions could be defined for userspace keyrings. 
Refer to Mat Martineau's LSS 2019 talk titled "Using and Implementing
Keyring Restrictions for Userspace" and the keyctl's "restrict_keyring"
option.

Mimi

