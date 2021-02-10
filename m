Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56731728F
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 22:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhBJVlk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 16:41:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233189AbhBJVlh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 16:41:37 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11ALWRbh160883;
        Wed, 10 Feb 2021 16:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=o6TuZSQpcdPy3WLJuSm6eQE5aim7yVvdU9t1MZ9OKtY=;
 b=fLVuTXw5GB0xrlUk9+oUdcgS4Vi41lMR5mxO36IQgNnpvqXZUxXWqWGdeA0m5zvj2Scq
 +udTAdoJOtISM3SBU9htGICE/uGZMMeAza8AluFqtfMB6Z1KD/2lqwHIVs/Ldt0qVzQy
 6T0qn1V/WUUPT1gqzHKvo8/YQhXm2vVLM1YokVqNYWHUXOT/Doel3iHglMPxEzVmPj1v
 dlLbS2J5sBWqKNlYfhgyBlE8ZY/Ucl8amu08c55zvJ2oiy8PqOPxyXi8g4lPez/Dj9Y3
 os136pOS/Ct+2LPLeGZYnITaB4OQe5LhdP9VRAmEznVx/zQM+omj1OKehdCf+VMC9oD6 Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36mqff0b67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 16:40:08 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11ALWXwH161540;
        Wed, 10 Feb 2021 16:40:07 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36mqff0b4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 16:40:07 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11ALQwK2018691;
        Wed, 10 Feb 2021 21:40:05 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 36hskb2jk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 21:40:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11ALe2Oq42926414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 21:40:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CECA211C05E;
        Wed, 10 Feb 2021 21:40:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2C2111C04A;
        Wed, 10 Feb 2021 21:39:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.111.148])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 10 Feb 2021 21:39:56 +0000 (GMT)
Message-ID: <594445d01e085875b97b46be726247f89d1e6661.camel@linux.ibm.com>
Subject: Re: [PATCH v17 00/10] Carry forward IMA measurement log on kexec on
 ARM64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        vincenzo.frascino@arm.com, Mark Rutland <mark.rutland@arm.com>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Wed, 10 Feb 2021 16:39:55 -0500
In-Reply-To: <cf7930239b93044a1be353556b7dc730e024f658.camel@linux.ibm.com>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
         <20210210171500.GA2328209@robh.at.kernel.org>
         <5c002c32-bc49-acda-c641-7b1494ea292d@linux.microsoft.com>
         <CAL_JsqLmdqfFF8u=dE+dQz+6ngv=moWkQF8tpZjUCX-vHuvU_w@mail.gmail.com>
         <cf7930239b93044a1be353556b7dc730e024f658.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_10:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102100186
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-02-10 at 15:55 -0500, Mimi Zohar wrote:
> On Wed, 2021-02-10 at 14:42 -0600, Rob Herring wrote:
> > On Wed, Feb 10, 2021 at 11:33 AM Lakshmi Ramasubramanian
> 
> > Ideally, we don't apply the same patch in 2 branches. It looks like
> > there's a conflict but no real dependence on the above patch (the
> > ima_buffer part). The conflict seems trivial enough that Linus can
> > resolve it in the merge window.
> > 
> > Or Mimi can take the whole thing if preferred?
> 
> How about I create a topic branch with just the two patches, allowing
> both of us to merge it?   There shouldn't be a problem with re-writing
> next-integrity history.

The 2 patches are now in the ima-kexec-fixes branch.

Mimi

