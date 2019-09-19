Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF16BB720B
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2019 06:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfISEAW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Sep 2019 00:00:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbfISEAV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Sep 2019 00:00:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8J3vSTd042757;
        Wed, 18 Sep 2019 23:59:28 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3ve896ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Sep 2019 23:59:28 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8J3tIOP010643;
        Thu, 19 Sep 2019 03:59:26 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02wdc.us.ibm.com with ESMTP id 2v3vbtt8s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Sep 2019 03:59:26 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8J3xQVi54001986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 03:59:26 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 633B8AE05C;
        Thu, 19 Sep 2019 03:59:26 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53748AE05F;
        Thu, 19 Sep 2019 03:59:22 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.160.236])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu, 19 Sep 2019 03:59:22 +0000 (GMT)
References: <20190913225009.3406-1-prsriva@linux.microsoft.com> <20190913225009.3406-2-prsriva@linux.microsoft.com> <1568816111.16709.68.camel@linux.ibm.com> <1568841696.4733.3.camel@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Prakhar Srivastava <prsriva@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, sboyd@kernel.org
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima measurement log in kexec_file_load
In-reply-to: <1568841696.4733.3.camel@linux.ibm.com>
Date:   Thu, 19 Sep 2019 00:59:11 -0300
Message-ID: <871rwd2ay8.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190034
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Wed, 2019-09-18 at 10:15 -0400, Mimi Zohar wrote:
>
>> > +	uint64_t tmp_start, tmp_end;
>> > +
>> > +	propStart = of_find_property(of_chosen, "linux,ima-kexec-buffer",
>> > +				     NULL);
>> > +	if (propStart) {
>> > +		tmp_start = fdt64_to_cpu(*((const fdt64_t *) propStart));
>> > +		ret = of_remove_property(of_chosen, propStart);
>> > +		if (!ret) {
>> > +			return ret;
>> > +		}
>> > +
>> > +		propEnd = of_find_property(of_chosen,
>> > +					   "linux,ima-kexec-buffer-end", NULL);
>> > +		if (!propEnd) {
>> > +			return -EINVAL;
>> > +		}
>> > +
>> > +		tmp_end = fdt64_to_cpu(*((const fdt64_t *) propEnd));
>> > +
>> > +		ret = of_remove_property(of_chosen, propEnd);
>> > +		if (!ret) {
>> > +			return ret;
>> > +		}
>> 
>> There seems to be quite a bit of code duplication in this function and
>> in ima_get_kexec_buffer().  It could probably be cleaned up with some
>> refactoring.
>
> Sorry, my mistake.  One calls of_get_property(), while the other calls
> of_find_property().

of_get_property() is a thin wrapper around of_find_property(), so if
that's the only difference I think they can still be merged.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
