Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6621F1871
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2020 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgFHMGW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jun 2020 08:06:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729620AbgFHMGW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jun 2020 08:06:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058C4Q96145904;
        Mon, 8 Jun 2020 08:05:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31hmpwrj2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 08:05:21 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 058C5DwW150022;
        Mon, 8 Jun 2020 08:05:17 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31hmpwrgxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 08:05:16 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058C162I023522;
        Mon, 8 Jun 2020 12:02:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 31g2s81kfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 12:02:31 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 058C2SIj47775812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jun 2020 12:02:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C857EA405C;
        Mon,  8 Jun 2020 12:02:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C0B5A4068;
        Mon,  8 Jun 2020 12:02:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.150])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jun 2020 12:02:25 +0000 (GMT)
Message-ID: <1591617744.4638.42.camel@linux.ibm.com>
Subject: Re: [v1 PATCH 1/2] Refactoring carrying over IMA measuremnet logs
 over Kexec.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, robh+dt@kernel.org,
        frowand.list@gmail.com, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com, pasha.tatashin@soleen.com,
        allison@lohutok.net, kstewart@linuxfoundation.org,
        takahiro.akashi@linaro.org, tglx@linutronix.de,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        masahiroy@kernel.org, james.morse@arm.com, bhsharma@redhat.com,
        mbrugger@suse.com, hsinyi@chromium.org, tao.li@vivo.com,
        christophe.leroy@c-s.fr, gregkh@linuxfoundation.org,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        balajib@linux.microsoft.com
Date:   Mon, 08 Jun 2020 08:02:24 -0400
In-Reply-To: <20200607233323.22375-2-prsriva@linux.microsoft.com>
References: <20200607233323.22375-1-prsriva@linux.microsoft.com>
         <20200607233323.22375-2-prsriva@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_11:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0
 cotscore=-2147483648 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=945
 priorityscore=1501 phishscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080093
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

On Sun, 2020-06-07 at 16:33 -0700, Prakhar Srivastava wrote:
> This patch moves the non-architecture specific code out of powerpc and
>  adds to security/ima. 
> Update the arm64 and powerpc kexec file load paths to carry the IMA measurement
> logs.

From your patch description, this patch should be broken up.  Moving
the non-architecture specific code out of powerpc should be one patch.
 Additional support should be in another patch.  After each patch, the
code should work properly.

Before posting patches, please review them, making sure
unnecessary/unwanted changes haven't crept in - commenting out code,
moving code without removing the original code.

thanks,

Mimi
