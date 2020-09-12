Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E0267770
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Sep 2020 05:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgILDYm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 23:24:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56632 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgILDYl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 23:24:41 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08C3Iepe147448;
        Fri, 11 Sep 2020 23:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=V5pwQsadCcCfTYtSw89ovAAuc89xWD6rBGuanc9BszQ=;
 b=nHTTsRWDXBiynYEqNGc6Q7UQ1NYXdkr/3h+oQ4i8hsHdF8zbuX+E5ddXNAm6o8+FmPL9
 Be5UOLRs5yBXMbaNxkOzM+KvSrHhIklQOqKrWHs3NI6LW7Y4GrmC/1FECHJzOpwxVTHW
 3CVC65cnZq41JVxtrFsS1LslQ6EvPwMPkM7uuMM7BC587xsn6/3I6EkzAN0C5a1PfLKV
 KxeiryBiyOB5QiUKBTOP1Bq+bXx9uUm60TTxl/fFocIWG/nyMl20A3uYMpdgYb5fwBGm
 rRmmPRH2qXSZvrkudnixLHWcP/oIrFYezh2GbnLTBc+Q9ZQT2Y9kQQMod5TRUFvRRftX 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gpakg1s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 23:24:01 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08C3JVIK148553;
        Fri, 11 Sep 2020 23:24:01 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33gpakg1ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 23:24:00 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08C3LouD012165;
        Sat, 12 Sep 2020 03:24:00 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 33gny7r4s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Sep 2020 03:24:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08C3NtlG65733052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Sep 2020 03:23:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07AFE7805E;
        Sat, 12 Sep 2020 03:23:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FD337805C;
        Sat, 12 Sep 2020 03:23:51 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.151.100])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Sat, 12 Sep 2020 03:23:51 +0000 (GMT)
References: <20200908230856.9799-1-nramas@linux.microsoft.com>
 <20200908230856.9799-4-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, gregkh@linuxfoundation.org,
        james.morse@arm.com, catalin.marinas@arm.com, sashal@kernel.org,
        will@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, robh+dt@kernel.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        kstewart@linuxfoundation.org, takahiro.akashi@linaro.org,
        tglx@linutronix.de, masahiroy@kernel.org, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com
Subject: Re: [PATCH v6 3/3] arm64: Add IMA kexec buffer to DTB
In-reply-to: <20200908230856.9799-4-nramas@linux.microsoft.com>
Date:   Sat, 12 Sep 2020 00:23:49 -0300
Message-ID: <87363nu18a.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-12_01:2020-09-10,2020-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=2
 mlxlogscore=691 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009120027
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> Any existing FDT_PROP_IMA_KEXEC_BUFFER property in the device tree
> needs to be removed and its corresponding memory reservation in
> the currently running kernel needs to be freed.
>
> The address and size of the current kernel's IMA measurement log need
> to be added to the device tree's IMA kexec buffer node and memory for
> the buffer needs to be reserved for the log to be carried over to
> the next kernel on the kexec call.
>
> Remove any existing FDT_PROP_IMA_KEXEC_BUFFER property in the device
> tree and free the corresponding memory reservation in the currently
> running kernel. Add FDT_PROP_IMA_KEXEC_BUFFER property to the device
> tree and reserve the memory for storing the IMA log.
> Update CONFIG_KEXEC_FILE to select CONFIG_HAVE_IMA_KEXEC to indicate
> that the IMA measurement log information is present in the device tree
> for ARM64.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
