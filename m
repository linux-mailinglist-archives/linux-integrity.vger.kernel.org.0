Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87AE2E10FA
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Dec 2020 01:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgLWA6y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Dec 2020 19:58:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20732 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgLWA6y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Dec 2020 19:58:54 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BN0VvxC137548;
        Tue, 22 Dec 2020 19:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=b15DogtgczLGlZaeKSpAvoIpoWddBPgjvjiVLoVvEfU=;
 b=b43YsUt3dX2cdl71uA3qNAQdBSNFksoR1SKm4o9qtBJywmlIed5FCPBYT1TclHTHASTw
 2bhY6cOoS7nUEe7dtd4Smo9QcV3MYqFVUbOO0xjH444FUZEvw5WaytQ1TojLRzdW/LiU
 sJEe17n5mIfLs2XwTS2pyvyDz99ArqbHKu+nB8Z7rS3ijWzXWg+G749uLBqckKEXjnPg
 AElLzjr+YH4Yo8YFM8XHTADFQb7a6FciCGiCbD7/BkhMavRWsp07cJq0yD6l3K7oI3SY
 ogqhyXaf570gh4kzLbQNtWOzD9Y6xBFwScVAix6zBDFfGHcpLh/zanGZzMb7WKymEHJG 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35ku9ygja0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:57:39 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BN0or4w057939;
        Tue, 22 Dec 2020 19:57:38 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35ku9ygj9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 19:57:38 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BN0rEWU015046;
        Wed, 23 Dec 2020 00:57:37 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02wdc.us.ibm.com with ESMTP id 35km4gtmfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 00:57:37 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BN0vZNE26804716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Dec 2020 00:57:35 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A8F4BE054;
        Wed, 23 Dec 2020 00:57:35 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AB3EBE04F;
        Wed, 23 Dec 2020 00:57:27 +0000 (GMT)
Received: from manicouagan.localdomain (unknown [9.80.219.136])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 23 Dec 2020 00:57:27 +0000 (GMT)
References: <20201219175713.18888-1-nramas@linux.microsoft.com>
 <20201219175713.18888-4-nramas@linux.microsoft.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, robh@kernel.org, takahiro.akashi@linaro.org,
        gregkh@linuxfoundation.org, will@kernel.org,
        catalin.marinas@arm.com, mpe@ellerman.id.au, james.morse@arm.com,
        sashal@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
        frowand.list@gmail.com, vincenzo.frascino@arm.com,
        mark.rutland@arm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v13 3/6] kexec: Use fdt_appendprop_addrrange() to add
 ima buffer to FDT
In-reply-to: <20201219175713.18888-4-nramas@linux.microsoft.com>
Date:   Tue, 22 Dec 2020 21:57:25 -0300
Message-ID: <8735zxl4p6.fsf@manicouagan.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_13:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=961 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220175
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> fdt_appendprop_addrrange() function adds a property, with the given name,
> to the device tree at the given node offset, and also sets the address
> and size of the property. This function should be used to add
> "linux,ima-kexec-buffer" property to the device tree and set the address
> and size of the IMA measurement buffer, instead of using custom function.
>
> Use fdt_appendprop_addrrange() to add  "linux,ima-kexec-buffer" property
> to the device tree. This property holds the address and size of
> the IMA measurement buffer that needs to be passed from the current
> kernel to the next kernel across kexec system call.
>
> Remove custom code that is used in setup_ima_buffer() to add
> "linux,ima-kexec-buffer" property to the device tree.
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  drivers/of/kexec.c | 57 ++++------------------------------------------
>  1 file changed, 5 insertions(+), 52 deletions(-)

This is a nice improvement, thanks.

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
