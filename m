Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC292CA197
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 12:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgLALiy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 06:38:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728084AbgLALix (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 06:38:53 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BWqu3013055;
        Tue, 1 Dec 2020 06:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NXG0xBf15AWAWy8DcAPe2Vw2ea6Zwvt5B2GjsVQn0/E=;
 b=qOoHSw6P/1mg5IS6eY/5835WxNcr5tUjzWkC2SxYQbug6GTJjeAgDgaS15V5jCUjjLDi
 7oP6tn7QU8POtnsn2RZRrgT6wrP67ROODj2vnc3kY2uR4duU7OS3uWbQgNOXesq98G95
 Nf//UcttLlB/BCEhLgq4vVwaGxWYNxAhHodMdxKNOexucBhn+/l8mbf2S1UJ0NSxqSCE
 J4unIoVmM17HXnCD3jicCQK043A4Eus5iE3yRck1a0elu7BqLVpEZa+8UxFfR/B6y8Xn
 wUFJ5WKHZfLNfll6+A3indfo9oE0Sg8C9M2yOz5bQ5b7ZqmjHg8Jcx6aoH0VAAELbaC6 GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jaaw77v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:37:38 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B1BXRMT018693;
        Tue, 1 Dec 2020 06:37:38 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355jaaw76w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 06:37:38 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B1BMKj9014895;
        Tue, 1 Dec 2020 11:37:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 354fpd9trd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 11:37:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B1BbWBW6750954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Dec 2020 11:37:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3A77AE055;
        Tue,  1 Dec 2020 11:37:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED7A3AE045;
        Tue,  1 Dec 2020 11:37:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.54.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Dec 2020 11:37:25 +0000 (GMT)
Message-ID: <5c2a18f72af861be6494c2f325e83835be8e2f7e.camel@linux.ibm.com>
Subject: Re: [PATCH v9 3/8] ima: Define get_ima_kexec_buffer() in drivers/of
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
Date:   Tue, 01 Dec 2020 06:37:25 -0500
In-Reply-To: <20201113192243.1993-4-nramas@linux.microsoft.com>
References: <20201113192243.1993-1-nramas@linux.microsoft.com>
         <20201113192243.1993-4-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_04:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=347 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010075
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-11-13 at 11:22 -0800, Lakshmi Ramasubramanian wrote:
> The function do_get_kexec_buffer(), defined in arch/powerpc/kexec/ima.c,
> retrieves the address and size of the given property from the device
> tree blob. This function does not have architecture specific code, but is
> currently limited to powerpc. This function correctly handles a device
> tree property that is a child node of the root node, but not anything
> other than the immediate root child nodes.
> 
> Define an architecture independent function, namely
> get_ima_kexec_buffer(), in "drivers/of/ima_kexec.c". This function
> retrieves the chosen node, namely "linux,ima-kexec-buffer", from

Please remove the word "namely", here, and throughout the patch sets.

> the device tree, and returns the address and size of the buffer used
> for carrying forward the IMA measurement log across kexec system call.

get_ima_kexec_buffer() inlines the existing do_get_kexec_buffer() and 
get_addr_size_cells() functions, leaving a local copy of
get_addr_size_cells().   Duplicating code isn't a good idea.

thanks,

Mimi

