Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D2A2A5097
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 21:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgKCUAY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 15:00:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgKCUAX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 15:00:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3J2Lnu088490;
        Tue, 3 Nov 2020 14:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=4J/NPZ6R6uvDycG9DBSAzzjj7JHE6SE2zqYmSpQ5XlM=;
 b=lRNi2qXWMP8bq/jyFj2Vk5ILWxLCOC76bI8cJGVdyBWDqEPrij50i3oylppCucz/QcGn
 hYMbaB/F3eB+y+vFA4GXoulkBaUeKTguPu87BH6JD/3mdIV4WYZ/O/RnR95YI8p3BcNS
 /J1o5V0MwG3zvbGcC+x7Lui2qT+32iz6Fe/hRafImkr96wA3fqiW5LuS7X8Gne6KRzK2
 AGKMKJeLUtFitVGp4L8QLGFG1e31xIP6XywYzsvaHfmga3Yga4KOENoLtV2jk2TK4ZTa
 Uqf0Xl19drPT442WU7waPNloC1mUXGSAeU52utySnqW/7LP/ydBA07394g7px187WH5b BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34k86d4yat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:59:50 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3Ju3YJ041580;
        Tue, 3 Nov 2020 14:59:49 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34k86d4ya1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:59:49 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3Jwjj6006002;
        Tue, 3 Nov 2020 19:59:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 34h0f6su6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 19:59:47 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3JxiKW8323706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 19:59:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6722AE051;
        Tue,  3 Nov 2020 19:59:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEFE4AE045;
        Tue,  3 Nov 2020 19:59:37 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.125.87])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 19:59:37 +0000 (GMT)
Message-ID: <5f2d658f63744387fe203bb215968100200b7fb6.camel@linux.ibm.com>
Subject: Re: [PATCH v8 1/4] powerpc: Refactor kexec functions to move arch
 independent code to drivers/of
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        gregkh@linuxfoundation.org, james.morse@arm.com,
        catalin.marinas@arm.com, sashal@kernel.org, will@kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, prsriva@linux.microsoft.com,
        balajib@linux.microsoft.com
Date:   Tue, 03 Nov 2020 14:59:36 -0500
In-Reply-To: <313e87c1-8f58-b1e0-db3e-950d2ee66927@linux.microsoft.com>
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
         <20201030174429.29893-2-nramas@linux.microsoft.com>
         <506372c01decf59bc2ef39c92a86ba7f6f2ae81b.camel@linux.ibm.com>
         <313e87c1-8f58-b1e0-db3e-950d2ee66927@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=2 impostorscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030125
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-11-03 at 11:15 -0800, Lakshmi Ramasubramanian wrote:
> On 11/3/20 6:55 AM, Mimi Zohar wrote:
> 
> Hi Mimi,
> 
> Thanks for reviewing the patches.
> 
> > On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
> >> The functions remove_ima_buffer() and delete_fdt_mem_rsv() that handle
> >> carrying forward the IMA measurement logs on kexec for powerpc do not
> >> have architecture specific code, but they are currently defined for
> >> powerpc only.
> > 
> > ^ ... logs on kexec, do not have architecture specific code, but are
> > currently limited to powerpc.
> Will make this change.
> 
> > 
> >>
> >> remove_ima_buffer() and delete_fdt_mem_rsv() are used to remove
> >> the IMA log entry from the device tree and free the memory reserved
> >> for the log. These functions need to be defined even if the current
> >> kernel does not support carrying forward IMA log across kexec since
> >> the previous kernel could have supported that and therefore the current
> >> kernel needs to free the allocation.
> > 
> > The first paragraph describes these function as "handle carrying
> > forward the IMA measurement logs on kexec", while this paragraph says
> > "are used to remove the IMA log entry".  Consider listing all of the
> > functions being moved in the first paragrah, then "handle carrying
> > forward" could be expanded to "carrying ... and removing".
> Sure.

Sorry, even with naming do_get_kexec_buffer(), the measurement list
isn't being carried across kexec.   Please adjust the wording.

> 
> > 
> >>
> >> Rename remove_ima_buffer() to remove_ima_kexec_buffer().
> >> Define remove_ima_kexec_buffer() and delete_fdt_mem_rsv() in
> >> drivers/of/fdt.c. A later patch in this series will use these functions
> >> to free the allocation, if any, made by the previous kernel for ARM64.
> > 
> > - ^Define -> Move
> > - Three functions are being moved, but only two are listed.
> > "do_get_kexec_buffer" is not mentioned.
> > - Don't refer to a later patch, but explain the purpose here.  For
> > example, "Move ... , making them accessible to other archs."
> Sure.
> 
> > 
> >>
> >> Define FDT_PROP_IMA_KEXEC_BUFFER for the chosen node, namely
> >> "linux,ima-kexec-buffer", that is added to the DTB to hold
> >> the address and the size of the memory reserved to carry
> >> the IMA measurement log.
> > 
> > The above two paragraphs describe renaming a function and defining a
> > chosen node.  These two preparatory changes should be made,
> > independently of each other, prior to this patch.  This patch should be
> > limited to moving code, with the subject line truncated to "move arch
> > independent code to drivers/of".
> > 
> 
> Just to be clear -
> 
> Split this patch into 3 parts as listed below:
> 
> PATCH #1: Rename remove_ima_buffer() to remove_ima_kexec_buffer()
> PATCH #2: Define the chosen node
> PATCH #3: Move the functions to drivers/of/fdt.c

yes, thanks.

Mimi

> 
> Sure - I'll make the above changes and update patch descriptions 
> accordingly.

