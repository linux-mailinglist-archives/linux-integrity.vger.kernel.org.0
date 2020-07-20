Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1487D226D12
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Jul 2020 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgGTR1F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Jul 2020 13:27:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728939AbgGTR1E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Jul 2020 13:27:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KH0oxJ094313;
        Mon, 20 Jul 2020 13:26:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32bw90ccyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 13:26:59 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06KH0sYQ094749;
        Mon, 20 Jul 2020 13:26:58 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32bw90ccy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 13:26:58 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KHOd0J028918;
        Mon, 20 Jul 2020 17:26:56 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 32dbmn0435-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 17:26:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06KHQs8K51970208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 17:26:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29DE142063;
        Mon, 20 Jul 2020 17:26:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0690F42066;
        Mon, 20 Jul 2020 17:26:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.145.253])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 17:26:52 +0000 (GMT)
Message-ID: <1595266012.5055.51.camel@linux.ibm.com>
Subject: Re: [PATCH v3 4/5] LSM: Define SELinux function to measure security
 state
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Prakhar Srivastava <prsriva02@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 20 Jul 2020 13:26:52 -0400
In-Reply-To: <CAEjxPJ7VH18bEo6+U1GWrx=tHVGr=6XtF5_ygcfQYgdtZ74J+g@mail.gmail.com>
References: <20200717222819.26198-1-nramas@linux.microsoft.com>
         <20200717222819.26198-5-nramas@linux.microsoft.com>
         <CAEjxPJ7xQtZToF4d2w_o8SXFKG9kPZaWTWTFqyC-7GwBWnQa0A@mail.gmail.com>
         <c0fbfcf3-ec36-872a-c389-b3fea214848c@linux.microsoft.com>
         <CAEjxPJ7VH18bEo6+U1GWrx=tHVGr=6XtF5_ygcfQYgdtZ74J+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-07-20 at 13:06 -0400, Stephen Smalley wrote:
> 
> 
> I applied the patch series on top of the next-integrity branch, added
> measure func=LSM_STATE to ima-policy, and booted that kernel.  I get
> the following entries in ascii_runtime_measurements, but seemingly
> missing the final field:
> 
> 10 8a09c48af4f8a817f59b495bd82971e096e2e367 ima-ng
> sha256:21c3d7b09b62b4d0b3ed15ba990f816b94808f90b76787bfae755c4b3a44cd24
> selinux-state
> 10 e610908931d70990a2855ddb33c16af2d82ce56a ima-ng
> sha256:c8898652afd5527ef4eaf8d85f5fee1d91fcccee34bc97f6e55b96746bedb318
> selinux-policy-hash
> 
> Thus, I cannot verify. What am I missing?

Missing is "template=ima-buf" on the policy rule.

Tyler's patch set just added some support for verifying the policy.
 Refer to ima_validate_rule().  There are still some things missing.
 For example, nayna noticed that making sure that asymmetric key
support is enabled.  Another example is requiring "template=" for any
of the buffer measurements.  Template names can be defined
dynamically, so it will need to support either format:

measure func=KEXEC_CMDLINE template=ima-buf 
measure func=KEXEC_CMDLINE template=d-ng|n-ng|buf

Mimi
