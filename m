Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E0E51A158
	for <lists+linux-integrity@lfdr.de>; Wed,  4 May 2022 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350844AbiEDNyO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 09:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350730AbiEDNyN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 09:54:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8E53614F;
        Wed,  4 May 2022 06:50:36 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244D89Ej032359;
        Wed, 4 May 2022 13:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=WafK932ObesQwXzcMhdlCMkFPACyb1XIUSZ459VPeVM=;
 b=GfNGckMlqMq+2bwhPleFOSC33RhhJ4vd/ZnUwSi1ry8ZxLv9Yo+pDia/vvw1tHK/DaxP
 Fsn6sVF3RuRsKPBKZqkXjJJcUWUhDepRETNGVGGdk5k809wM9QCCUUyFZBdxEFYqrXic
 HIafOhw9ohW58LZ/tmo+XT9XMWPIVw0XnFoO1TPkuU22oLtiPCnQ9BSxS4e6LimOYvEe
 9Onef2st/5I3f3Y8skTfSEVheahP2ryE4xDJWzuQ2ZJDPv2fQvKsAGP8yzUn5rZNeisX
 UEV0wobi3Y8gi966n79xFGkpFkmTGatgFNcCFOaTxj5QMHTOlhS250/UlfMJV1Wpodbb Gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fusjwhps8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 13:49:58 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 244DAc7l005951;
        Wed, 4 May 2022 13:49:58 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fusjwhpra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 13:49:58 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 244DmGHn003903;
        Wed, 4 May 2022 13:49:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3frvr8vm3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 May 2022 13:49:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 244DnoXO26018096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 May 2022 13:49:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14F0F42041;
        Wed,  4 May 2022 13:49:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 833B442045;
        Wed,  4 May 2022 13:49:51 +0000 (GMT)
Received: from sig-9-65-73-150.ibm.com (unknown [9.65.73.150])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 May 2022 13:49:51 +0000 (GMT)
Message-ID: <bbd6886aa5575765b5c223e1b4f5aab336fe4350.camel@linux.ibm.com>
Subject: Re: [PATCH v2] Carry forward IMA measurement log on kexec on x86_64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jonathan McDowell <noodles@fb.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Date:   Wed, 04 May 2022 09:49:51 -0400
In-Reply-To: <YnEZtisrvO0AhrAz@noodles-fedora.dhcp.thefacebook.com>
References: <YmgjXZphkmDKgaOA@noodles-fedora-PC23Y6EG>
         <7d7fa18d396439d98e26890f647fffdc9e7d8b20.camel@linux.ibm.com>
         <YnEZtisrvO0AhrAz@noodles-fedora.dhcp.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qoBAfW7MCTZ_vV3jXf2EyNBLgbNTv_mQ
X-Proofpoint-ORIG-GUID: zljCZxrC8b6iSRP8V_WObcC03bkZCfeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-04_04,2022-05-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2205040086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-05-03 at 12:02 +0000, Jonathan McDowell wrote:
> On Fri, Apr 29, 2022 at 05:30:10PM -0400, Mimi Zohar wrote:
> > > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> > > index 13753136f03f..419c50cfe6b9 100644
> > > --- a/security/integrity/ima/ima_kexec.c
> > > +++ b/security/integrity/ima/ima_kexec.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/seq_file.h>
> > >  #include <linux/vmalloc.h>
> > >  #include <linux/kexec.h>
> > > +#include <linux/memblock.h>
> > >  #include <linux/of.h>
> > >  #include <linux/ima.h>
> > >  #include "ima.h"
> > > @@ -134,10 +135,66 @@ void ima_add_kexec_buffer(struct kimage *image)
> > >  }
> > >  #endif /* IMA_KEXEC */
> > >  
> > > +#ifndef CONFIG_OF
> > > +static phys_addr_t ima_early_kexec_buffer_phys;
> > > +static size_t ima_early_kexec_buffer_size;
> > > +
> > > +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> > > +{
> > > +	if (size == 0)
> > > +		return;
> > > +
> > > +	ima_early_kexec_buffer_phys = phys_addr;
> > > +	ima_early_kexec_buffer_size = size;
> > > +}
> > > +
> > > +int __init ima_free_kexec_buffer(void)
> > > +{
> > > +	int rc;
> > > +
> > > +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> > > +		return -ENOTSUPP;
> > > +
> > > +	if (ima_early_kexec_buffer_size == 0)
> > > +		return -ENOENT;
> > > +
> > > +	rc = memblock_phys_free(ima_early_kexec_buffer_phys,
> > > +				ima_early_kexec_buffer_size);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	ima_early_kexec_buffer_phys = 0;
> > > +	ima_early_kexec_buffer_size = 0;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int __init ima_get_kexec_buffer(void **addr, size_t *size)
> > > +{
> > > +	if (!IS_ENABLED(CONFIG_HAVE_IMA_KEXEC))
> > > +		return -ENOTSUPP;

The Kconfig conditionally compiles ima_kexec.c based on
CONFIG_HAVE_IMA_KEXEC.  This test should be removed from here and from
ima_get_kexec_buffer().

CONFIG_IMA_KEXEC controls whether or not to carry the measurement list
to the next kernel, not whether the measurement list should be
restored.  Notice that ima_load_kexec_buffer() is not within the ifdef
CONFIG_IMA_KEXEC.

> > > +
> > > +	if (ima_early_kexec_buffer_size == 0)
> > > +		return -ENOENT;

There should always be at least one measurement - the boot_aggregate.

> > > +
> > > +	*addr = __va(ima_early_kexec_buffer_phys);
> > > +	*size = ima_early_kexec_buffer_size;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > 
> > Originally both ima_get_kexec_buffer() and ima_free_kexec_buffer() were
> > architecture specific.  Refer to commit 467d27824920 ("powerpc: ima:
> > get the kexec buffer passed by the previous kernel").  Is there any
> > need for defining them here behind an "#ifndef CONFIG_OF"?
> 
> Commit fee3ff99bc67 (powerpc: Move arch independent ima kexec functions
> to drivers/of/kexec.c) moved those functions to drivers/of/kexec.c as a
> more generic implementation so that ARM64 could use them too.
> 
> I think for platforms that use device tree that's the way to go, but the
> functions to generically set + get the IMA buffer for non device tree
> systems were useful enough to put in the IMA code rather than being x86
> specific. If you disagree I can move them under arch/x86/ (assuming the
> x86 folk agree using setup_data is the right way to go, I haven't seen
> any of them comment on this approach yet).

So other architectures will need to define CONFIG_HAVE_IMA_KEXEC, a
function to call ima_set_kexec_buffer() to restore the measurement
list, and a function equivalent to ima_setup_state().

After removing the unnecessary tests mentioned above, consider whether
there is still any benefit to defining these functions.

> > > +#else
> > > +
> > > +void __init ima_set_kexec_buffer(phys_addr_t phys_addr, size_t size)
> > > +{
> > > +	pr_warn("CONFIG_OF enabled, ignoring call to set buffer details.\n");
> > > +}
> > > +#endif /* CONFIG_OF */
> > > +
> > 
> > Only when "HAVE_IMA_KEXEC" is defined is this file included.  Why is
> > this warning needed?
> 
> x86 *can* have device tree enabled, but the only platform I'm aware that
> did it was OLPC and I haven't seen any of the distros enable it. I put
> this in so there's a warning if we have CONFIG_OF enabled on x86 and
> tried to pass the IMA log via setup_data. Can remove (or fold into the
> x86 code if we go that way).

Thanks for the explanation.

> > >  /*
> > >   * Restore the measurement list from the previous kernel.
> > >   */
> > > -void ima_load_kexec_buffer(void)
> > > +void __init ima_load_kexec_buffer(void)
> > >  {
> > >  	void *kexec_buffer = NULL;
> > >  	size_t kexec_buffer_size = 0;
> 
> J.

thanks,

Mimi

