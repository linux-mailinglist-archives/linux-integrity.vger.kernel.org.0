Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82C72551EE
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Aug 2020 02:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgH1AZ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Aug 2020 20:25:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29560 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727008AbgH1AZ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Aug 2020 20:25:58 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S02UdG071522;
        Thu, 27 Aug 2020 20:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=AKRlr9yzrlMX+oXYj4rWdBKCf/H4fqUfPXhXc7Hb7N0=;
 b=JQignyW3X0z1tE7o9coxmE26UND2CnEkeDsVm3SBrrrNxqaDCrjcJ/0ACPJjDaAt3B3o
 hQdggaz1tyxhH5e36+wtCdlrO0YB4jpN5u2/xIlcCL+qRxFh3EOsMC13Fgnzcmhrvz0K
 6+gT/gUWSTBxsKE3l+ClQNTb/lrqVVGJswsovH+6bEx0P0Ljmh6xPnnLPOCuBlWeEUgp
 KT9K/M7BsTshTE5zevVRbrKWx1vpDSQZlDvwEJngcDpAl/wJX8opRPywTIVX199yW5Nt
 PbId+SS32DJ9r/X/MOWcKCXXcCU5EPZOOLV/Tan1W+ccMfXXF3ODQcPtEmnPJb9+UoVg BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336nv9hxps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 20:25:23 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07S0ONet142875;
        Thu, 27 Aug 2020 20:25:22 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 336nv9hxpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 20:25:22 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07S0LmgR026137;
        Fri, 28 Aug 2020 00:25:21 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 332utu9hrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 00:25:21 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07S0PHrs63439142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 00:25:17 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 361C3BE04F;
        Fri, 28 Aug 2020 00:25:20 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D069BBE053;
        Fri, 28 Aug 2020 00:25:12 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.211.80.51])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Aug 2020 00:25:12 +0000 (GMT)
References: <20200819172134.11243-1-nramas@linux.microsoft.com>
 <20200819172134.11243-4-nramas@linux.microsoft.com>
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
Subject: Re: [PATCH v4 3/5] IMA: Refactor do_get_kexec_buffer() to call of_
 functions directly
In-reply-to: <20200819172134.11243-4-nramas@linux.microsoft.com>
Date:   Thu, 27 Aug 2020 21:25:10 -0300
Message-ID: <87zh6f7h21.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_14:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=676 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270183
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> do_get_kexec_buffer() calls another local function get_addr_size_cells()
> to get the address and size of the IMA measurement log buffer stored in
> the device tree. get_addr_size_cells() is small enough that it can be
> merged into do_get_kexec_buffer() and a function call can be avoided.
>
> Refactor do_get_kexec_buffer() to call of_ functions directly instead
> of calling get_addr_size_cells() and remove get_addr_size_cells().
>
> Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
