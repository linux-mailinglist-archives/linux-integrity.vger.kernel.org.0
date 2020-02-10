Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A274415844A
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 21:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJUeB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 15:34:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727003AbgBJUeB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 15:34:01 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AKV8xF135731
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 15:34:00 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u56amps-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 10 Feb 2020 15:34:00 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 10 Feb 2020 20:33:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 10 Feb 2020 20:33:53 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AKXpFe52560028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 20:33:51 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFA2D4C04E;
        Mon, 10 Feb 2020 20:33:51 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21EB04C040;
        Mon, 10 Feb 2020 20:33:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.140.79])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 20:33:50 +0000 (GMT)
Subject: Re: [RFC PATCH 0/2] ima: uncompressed module appraisal support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, dhowells@redhat.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        nayna@linux.ibm.com, tglx@linutronix.de, bauerman@linux.ibm.com,
        mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 10 Feb 2020 15:33:49 -0500
In-Reply-To: <90E53A33-530B-40FB-9982-2818FFD78D73@oracle.com>
References: <20200206164226.24875-1-eric.snowberg@oracle.com>
         <5c246616-9a3a-3ed2-c1f9-f634cef511c9@linux.vnet.ibm.com>
         <09D68C13-75E2-4BD6-B4E6-F765B175C7FD@oracle.com>
         <1581087096.5585.597.camel@linux.ibm.com>
         <330BDFAC-E778-4E9D-A2D2-DD81B745F6AB@oracle.com>
         <1581097201.5585.613.camel@linux.ibm.com>
         <764C5FC8-DF0C-4B7A-8B5B-FD8B83F31568@oracle.com>
         <1581100125.5585.623.camel@linux.ibm.com>
         <992E95D5-D4B9-4913-A36F-BB47631DFE0A@oracle.com>
         <1581101672.5585.628.camel@linux.ibm.com>
         <C25E5885-F00B-48C0-AEF1-FA3014B2FDA6@oracle.com>
         <1581205431.5585.645.camel@linux.ibm.com>
         <0F13CB66-6962-44AC-A20D-CCBD82B43625@oracle.com>
         <1581354556.5585.827.camel@linux.ibm.com>
         <90E53A33-530B-40FB-9982-2818FFD78D73@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021020-0012-0000-0000-000003859968
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021020-0013-0000-0000-000021C21253
Message-Id: <1581366829.5585.898.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_07:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002100148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-02-10 at 12:24 -0700, Eric Snowberg wrote:
> > On Feb 10, 2020, at 10:09 AM, Mimi Zohar <zohar@linux.ibm.com> wrote:

> >> 
> >> Ok, understood, “modsig” refers to strictly kernel module appended signatures
> >> without regard to the keyring that verifies it.  Since there are inconsistencies
> >> here, would you consider something like my first patch?  It will verify an 
> >> uncompressed kernel module containing an appended signature  when the public key
> >> is contained within the kernel keyring instead of the ima keyring.  Why force a 
> >> person to add the same keys into the ima keyring for validation?  Especially when
> >> the kernel keyring is now used to verify appended signatures in the compressed
> >> modules.
> > 
> > Different use case scenarios have different requirements.  Suppose for
> > example that the group creating the kernel image is not the same as
> > using it.  The group using the kernel image could sign all files,
> > including kernel modules (imasig), with their own private key. Only
> > files that they signed would be permitted.  Your proposal would break
> > the current expectations, allowing kernel modules signed by someone
> > else to be loaded.
> > 
> 
> All the end user needs to do is compress any module created by the group that built
> the original kernel image to work around the scenario above.  Then the appended 
> signature in the compressed module will be verified by the kernel keyring. Does 
> this mean there is a security problem that should be fixed, if this is a concern?

Again, the issue isn't compressed/uncompressed kernel modules, but the
syscall used to load the kernel module.  IMA can prevent using the the
init_module syscall.  Refer to the ima_load_data() LOADING_MODULE
case.

Mimi

