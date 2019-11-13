Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED563FBA8D
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2019 22:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfKMVSc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Nov 2019 16:18:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726439AbfKMVSc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Nov 2019 16:18:32 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADL7N9e140537
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 16:18:31 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8rpht2e9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Nov 2019 16:18:30 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 13 Nov 2019 21:18:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Nov 2019 21:18:26 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xADLIPfY31981770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Nov 2019 21:18:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5781CAE053;
        Wed, 13 Nov 2019 21:18:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DFE4AE045;
        Wed, 13 Nov 2019 21:18:24 +0000 (GMT)
Received: from dhcp-9-31-103-201.watson.ibm.com (unknown [9.31.103.201])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Nov 2019 21:18:24 +0000 (GMT)
Subject: Re: [PATCH v6 2/3] IMA: Define an IMA hook to measure keys
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Nov 2019 16:18:23 -0500
In-Reply-To: <8eba665e-637c-d341-c77d-4f2645d3b246@linux.microsoft.com>
References: <20191113184658.2862-1-nramas@linux.microsoft.com>
         <20191113184658.2862-3-nramas@linux.microsoft.com>
         <1573675761.4843.13.camel@linux.ibm.com>
         <8eba665e-637c-d341-c77d-4f2645d3b246@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19111321-0028-0000-0000-000003B6A66E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111321-0029-0000-0000-00002479B079
Message-Id: <1573679903.4517.5.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911130175
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-13 at 12:52 -0800, Lakshmi Ramasubramanian wrote:
> On 11/13/19 12:09 PM, Mimi Zohar wrote:
> >
> > All that is is needed is the key and public_key structures, which are
> > defined in include/linux/keys.h and include/crypto/public_key.h.  If
> > the keys subsystem is disabled, then the new IMA hook won't be called.
> >   There's no need for a new Kconfig option or a new file.
> > 
> > Please move the hook to just after ima_kexec_cmdline().
> > 
> > Mimi
> 
> Yes - IMA hook won't be called when KEYS subsystem is disabled.
> 
> But, build dependency is breaking since "struct key" is not defined 
> without CONFIG_KEYS.
> 
> Sasha was able to craft a .config that enabled IMA without enabling KEYS 
> and found the build break.

Yes, thanks for pointing out the "#ifdef CONFIG_KEYS" in keys.h.  A
separate file is needed, as you pointed out, but still no need for a
new Kconfig.  The ima/Makefile can be based on CONFIG_KEYS.

Mimi

