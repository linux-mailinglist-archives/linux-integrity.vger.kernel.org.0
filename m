Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D310C2C95B0
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 04:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgLADSD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 22:18:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32818 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbgLADSC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 22:18:02 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B131cAv060829;
        Mon, 30 Nov 2020 22:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=1jmy35x0vr7C4X6dggumRbQlb2Eb0tL0Obh/EuedGys=;
 b=AFwcoEKt/tLxFkUpsMxBeDlbbKmJdB7nSHYqOW6dPid4X7qxcYWkVo73E1gW4tTXwyNO
 jT4KL93EkGLf1x4dIdJ7GStGCFob6e0WQxjhtFn+DhJPTjxsAKGANjZgcmej2Ty9xqkR
 8mH7ap5Q4zDG1Qsq5hsJ08EO/HxxH53qfsrl6KMqwy/eDQ0n5HuOnCPazQWxvOMOncJO
 eeDVymnGiktnb63upCSAAK/k1entTE+PcoybMMsj3egyXEA0/UTaTLHDgGPVceCQ0Vep
 qgSd41dPIEXEgIK+HZvGTc77fJsCitrRLmrwDjgO1ZpjYgg7TFQp5mf+ctGRDOqfAUtz WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355d9crpss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 22:16:46 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B13BnAO100587;
        Mon, 30 Nov 2020 22:16:43 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355d9crpsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 22:16:43 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B13Gb33015723;
        Tue, 1 Dec 2020 03:16:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 353e68anwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 03:16:41 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B13Gd1Y63046118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 03:16:39 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27E1F42042;
        Tue,  1 Dec 2020 03:16:39 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E759D4203F;
        Tue,  1 Dec 2020 03:16:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.59.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 03:16:31 +0000 (GMT)
Message-ID: <582bb3537b10f55c0825ec48e2fc0f6b310efeaa.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/8] powerpc: fix compiler warnings and errors
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
Date:   Mon, 30 Nov 2020 22:16:30 -0500
In-Reply-To: <20201113192243.1993-2-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
         <20201113192243.1993-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012010015
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Fri, 2020-11-13 at 11:22 -0800, Lakshmi Ramasubramanian wrote:
> The function prototype for the functions defined in ima.c for powerpc
> are given in the header file ima.h. But this header file is not
> included in ima.c resulting in compilation errors such as given below.
> 
> arch/powerpc/kexec/ima.c:56:5: error: no previous prototype for 'ima_get_kexec_buffer' [-Werror=missing-prototypes]
>    56 | int ima_get_kexec_buffer(void **addr, size_t *size)
>       |     ^~~~~~~~~~~~~~~~~~~~
> 
> The function parameters for remove_ima_buffer() and
> arch_ima_add_kexec_buffer() are not described in the function header
> resulting in warnings such as given below.
> 
> arch/powerpc/kexec/ima.c:111: warning: Function parameter or member 'fdt' not described in 'remove_ima_buffer'
> 
> Include ima.h in ima.c for powerpc. Describe the function parameters for
> remove_ima_buffer() and arch_ima_add_kexec_buffer().
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

thanks,

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

