Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16122E0BA9
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 15:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgLVO2C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 09:28:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726868AbgLVO2B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 09:28:01 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BME2Ewp030714;
        Tue, 22 Dec 2020 09:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=t7mh7qSe2dZshMhzvQ4TKn7yhZMhWv9/dyw8UHUoins=;
 b=rKh99nCLhMi5Cuwifv43Nj7SKXdgiUFtE3YCvDhWeS6tDZKnExJUXMfoCOrlJ4puVdeK
 3ZT06vHqAyQ1Px4BXXFbJZ+u3CNTkfYh5VgHSxqMkzsCK/13yoZzl9g9YELWzX0+wSVn
 Bp8whtELTClCCzIYc33xhA3biOYg+4enksfzcrQWhzCajGuPeq9t5fDuKPe+lEf7KwDA
 b41J4j6ej9DXijpvk2ngG2Mnhb5UzpdjGiHNAHeM4IqEWwnmAMCgdt23ob1nvwahrunA
 +rSU7bL3ML1vg0f4GaYy5yqRatW/UMliNAyvIZUge5ZICAWjBbgNUWGQ7XEyPvqTzSAM 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kgkkk2dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 09:26:42 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BME2Oqp030941;
        Tue, 22 Dec 2020 09:26:39 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35kgkkk2bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 09:26:39 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMEM0Cm021227;
        Tue, 22 Dec 2020 14:26:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 35h958b473-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 14:26:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMEQWMj16777680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 14:26:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 057B94C050;
        Tue, 22 Dec 2020 14:26:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5F244C044;
        Tue, 22 Dec 2020 14:26:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.142])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Dec 2020 14:26:26 +0000 (GMT)
Message-ID: <a1a4526c0759eb3b5d70fb8edc89360718376def.camel@linux.ibm.com>
Subject: Re: [PATCH v13 2/6] powerpc: Move arch independent ima kexec
 functions to drivers/of/kexec.c
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Date:   Tue, 22 Dec 2020 09:26:25 -0500
In-Reply-To: <20201219175713.18888-3-nramas@linux.microsoft.com>
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
         <20201219175713.18888-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_06:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Sat, 2020-12-19 at 09:57 -0800, Lakshmi Ramasubramanian wrote:
> 
> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> index 4aff6846c772..b6c52608cb49 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -9,13 +9,6 @@ obj-$(CONFIG_PPC32)		+= relocate_32.o
>  
>  obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
>  
> -ifdef CONFIG_HAVE_IMA_KEXEC
> -ifdef CONFIG_IMA
> -obj-y				+= ima.o
> -endif
> -endif

Notice how "kexec/ima.o" is only included if the architecture supports
it and IMA is configured.  In addition only if CONFIG_IMA_KEXEC is
configured, is the IMA measurement list carried across kexec.  After
moving the rest of ima.c to drivers/of/kexec.c, this changes.   Notice
how drivers/of/Kconfig includes kexec.o:

obj-$(CONFIG_KEXEC_FILE) += kexec.o

It is not dependent on CONFIG_HAVE_IMA_KEXEC.  Shouldn't all of the
functions defined in ima.c being moved to kexec.o be defined within a
CONFIG_HAVE_IMA_KEXEC ifdef?

thanks,

Mimi

