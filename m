Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE92E0BA1
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Dec 2020 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgLVOYO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 09:24:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726904AbgLVOYN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 09:24:13 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMED8tm014924;
        Tue, 22 Dec 2020 09:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fPWPwvPi/aoBWryUBJI6BYM5do2SZBXbiZsCIGc53UY=;
 b=FDnBYSx9spaJkJjKuXk6Yauhbznp3nO73O6nssQwG47+QBCkZgbxK+Wn/o5SlNHzNI0J
 zXzKDvn+9GSj/1neUJwBcoOicXyHf6dhL8JNWcVo3YZkK/UQzFXciDYmb70rQ5wQ83ik
 cmvQP71NvbmnCY+AULLs9h07u7v8a37PMjVq8LFjyTw1NKT7TvZL38N4C6ow51aoTCoW
 sOx81pJqDam9PfoVdfO7c9clgjfmdE1McfADMo+RCFaO/frw6pDKpucjzdz7Kayh5svb
 DY3MTtQWQ12eBdtRREbH3iZmUEPQdelcqVnFTkYe5cvId7xHdWF3wEexXm6xJIBtFEH0 ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kjc2r7tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 09:22:41 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMEFIST021212;
        Tue, 22 Dec 2020 09:22:39 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kjc2r7r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 09:22:37 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMEMWUM017575;
        Tue, 22 Dec 2020 14:22:32 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 35h8sh34bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 14:22:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMEMTxt41812434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 14:22:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFF3A52051;
        Tue, 22 Dec 2020 14:22:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.142])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 509015204E;
        Tue, 22 Dec 2020 14:22:23 +0000 (GMT)
Message-ID: <8f412cb3b09c2c51707f0d8c6bc3dfd77962f7d5.camel@linux.ibm.com>
Subject: Re: [PATCH v13 1/6] ima: Move arch_ima_add_kexec_buffer() to ima
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
Date:   Tue, 22 Dec 2020 09:22:22 -0500
In-Reply-To: <20201219175713.18888-2-nramas@linux.microsoft.com>
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
         <20201219175713.18888-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_06:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=988 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220100
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2020-12-19 at 09:57 -0800, Lakshmi Ramasubramanian wrote:
> arch_ima_add_kexec_buffer() defined in "arch/powerpc/kexec/ima.c"
> sets up the address and size of the IMA measurement list in
> the architecture specific fields in kimage struct. This function does not
> have architecture specific code, but is currently limited to powerpc.
> 
> Move arch_ima_add_kexec_buffer() to ima.
> 
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

