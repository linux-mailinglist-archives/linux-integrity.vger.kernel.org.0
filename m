Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83462A48CB
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Nov 2020 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCO61 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Nov 2020 09:58:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32538 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727921AbgKCO5M (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Nov 2020 09:57:12 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3EVL1A133433;
        Tue, 3 Nov 2020 09:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=d+ttMI8RznKeqnuEOJDJAyYBTWIbZi5WbaijtL+dfYM=;
 b=XtwOPwn4xc4rk4l4d4p/pZnAyO/aP39L8sdnulaV0XxBXtS4HK7RiOGgvNI9SOzpR/1T
 /VtI+r7D9daNZXRLTpSV/uO83lge+N0pdMvcDOVyk/sHJBSeSsocYvA+aKjIyjJg2YRE
 bzX8DLNiCdD2htLFiGL/mIm2XNi2fCamR3xEnQ2SlToXGLJpr3KYn2VxHze/o0b537zC
 0RCkaQXsndmBxh0SZGLX64O+q91DGXpUnKHuLGtsVCCki4vtpC+Shj+06NzaQiHt9ETT
 8QSvsF7o5l+saaXOWU/oXshHTb5jyXfN9zrRGIt8E6GBOtB+tcAU8ZmjKbs2wOABNtLy FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34jwj1dvyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 09:56:15 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3EXTND149155;
        Tue, 3 Nov 2020 09:56:02 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34jwj1dvfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 09:55:59 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3Elr8Q023438;
        Tue, 3 Nov 2020 14:55:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 34h01khqe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:55:36 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3EtXsB1770012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 14:55:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1AFB4C04E;
        Tue,  3 Nov 2020 14:55:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46EE94C058;
        Tue,  3 Nov 2020 14:55:26 +0000 (GMT)
Received: from sig-9-65-255-16.ibm.com (unknown [9.65.255.16])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Nov 2020 14:55:26 +0000 (GMT)
Message-ID: <87f63dc12739b346d556f85537324d3ae055097d.camel@linux.ibm.com>
Subject: Re: [PATCH v8 2/4] powerpc: Refactor kexec functions to move arch
 independent code to ima
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
Date:   Tue, 03 Nov 2020 09:55:24 -0500
In-Reply-To: <20201030174429.29893-3-nramas@linux.microsoft.com>
References: <20201030174429.29893-1-nramas@linux.microsoft.com>
         <20201030174429.29893-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 suspectscore=11 adultscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=996 mlxscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030097
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Fri, 2020-10-30 at 10:44 -0700, Lakshmi Ramasubramanian wrote:
> The functions ima_get_kexec_buffer() and ima_free_kexec_buffer(),
> that handle carrying forward the IMA measurement logs on kexec for
> powerpc do not have architecture specific code, but they are currently
> defined for powerpc only.
> 
> Move ima_get_kexec_buffer() and ima_free_kexec_buffer() to IMA
> subsystem. A later patch in this series will use these functions for
> carrying forward the IMA measurement log for ARM64.
> 
> With the above refactoring arch/powerpc/kexec/ima.c contains only
> functions used when CONFIG_IMA_KEXEC is enabled. Update Makefile
> in arch/powerpc/kexec to include arch/powerpc/kexec/ima.c only
> when CONFIG_IMA_KEXEC is enabled.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Similar comments to 1/4.
-  Last line of first paragraph can be rephrased like " ... on kexec,
do not contain architecture specific code, but are currently limited to
powerpc."
-  This patch should be limited to moving existing functions.  
Truncate the Subject line to "Move arch independent IMA kexec functions
to ima_kexec.c."
- Don't refer to a later patch, but explain the purpose here.  For
example, "Move ... , making them accessible to other archs."
- The definition of "FDT_PROP_IMA_KEXEC_BUFFER" should be made as a
separate, prepartory patch, prior to the existing 1/4.  The resulting
code being moved in this patch (and similarly for 1/4) will be exactly
the same as the code being deleted.

thanks,

Mimi

