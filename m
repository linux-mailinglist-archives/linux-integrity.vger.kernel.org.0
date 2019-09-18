Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AACB6EBB
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Sep 2019 23:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfIRVVs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Sep 2019 17:21:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbfIRVVr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Sep 2019 17:21:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ILKOuZ109570
        for <linux-integrity@vger.kernel.org>; Wed, 18 Sep 2019 17:21:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v3vdng1b1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 18 Sep 2019 17:21:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 18 Sep 2019 22:21:44 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Sep 2019 22:21:39 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8ILLCm418743696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Sep 2019 21:21:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9517011C054;
        Wed, 18 Sep 2019 21:21:38 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA4B011C04A;
        Wed, 18 Sep 2019 21:21:36 +0000 (GMT)
Received: from dhcp-9-31-103-196.watson.ibm.com (unknown [9.31.103.196])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Sep 2019 21:21:36 +0000 (GMT)
Subject: Re: [RFC PATCH v1 1/1] Add support for arm64 to carry ima
 measurement log in kexec_file_load
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc:     arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, sboyd@kernel.org, bauerman@linux.ibm.com
Date:   Wed, 18 Sep 2019 17:21:36 -0400
In-Reply-To: <1568816111.16709.68.camel@linux.ibm.com>
References: <20190913225009.3406-1-prsriva@linux.microsoft.com>
         <20190913225009.3406-2-prsriva@linux.microsoft.com>
         <1568816111.16709.68.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091821-0028-0000-0000-0000039FA7EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091821-0029-0000-0000-00002461ACC4
Message-Id: <1568841696.4733.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-18_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180182
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-09-18 at 10:15 -0400, Mimi Zohar wrote:

> > +	uint64_t tmp_start, tmp_end;
> > +
> > +	propStart = of_find_property(of_chosen, "linux,ima-kexec-buffer",
> > +				     NULL);
> > +	if (propStart) {
> > +		tmp_start = fdt64_to_cpu(*((const fdt64_t *) propStart));
> > +		ret = of_remove_property(of_chosen, propStart);
> > +		if (!ret) {
> > +			return ret;
> > +		}
> > +
> > +		propEnd = of_find_property(of_chosen,
> > +					   "linux,ima-kexec-buffer-end", NULL);
> > +		if (!propEnd) {
> > +			return -EINVAL;
> > +		}
> > +
> > +		tmp_end = fdt64_to_cpu(*((const fdt64_t *) propEnd));
> > +
> > +		ret = of_remove_property(of_chosen, propEnd);
> > +		if (!ret) {
> > +			return ret;
> > +		}
> 
> There seems to be quite a bit of code duplication in this function and
> in ima_get_kexec_buffer().  It could probably be cleaned up with some
> refactoring.

Sorry, my mistake.  One calls of_get_property(), while the other calls
of_find_property().

Mimi

