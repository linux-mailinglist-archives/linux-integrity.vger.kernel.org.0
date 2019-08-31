Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D692FA4146
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Aug 2019 02:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfHaASG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 20:18:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728240AbfHaASF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 20:18:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7V06xuG072321;
        Fri, 30 Aug 2019 20:18:03 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uqabf602m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 20:18:02 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7V09sml001615;
        Sat, 31 Aug 2019 00:18:01 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 2ujvv75nxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Aug 2019 00:18:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7V0I1BD43909398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 31 Aug 2019 00:18:01 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2981DAC05E;
        Sat, 31 Aug 2019 00:18:01 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59193AC05B;
        Sat, 31 Aug 2019 00:17:59 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.207.220])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Sat, 31 Aug 2019 00:17:58 +0000 (GMT)
References: <20190829200532.13545-1-prsriva@linux.microsoft.com> <20190829200532.13545-2-prsriva@linux.microsoft.com> <20190830052347.8032F2073F@mail.kernel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Prakhar Srivastava <prsriva@linux.microsoft.com>,
        linux-arm-msm@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org,
        zohar@linux.ibm.com
Subject: Re: [RFC][PATCH 1/1] Carry ima measurement log for arm64 via kexec_file_load
In-reply-to: <20190830052347.8032F2073F@mail.kernel.org>
Date:   Fri, 30 Aug 2019 21:17:55 -0300
Message-ID: <87pnkmkx1o.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=751 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908310000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Stephen Boyd <sboyd@kernel.org> writes:
> A lot of this code looks DT generic. Can it be moved out of the arch
> layer to drivers/of/?

Yes, if this code could be in drivers/of/ it would be great! Perhaps the
 DT generic functions could go in drivers/of/fdt.c, and ones dealing
 with IMA nodes/properties could go in drivers/of/fdt_ima.c?

--
Thiago Jung Bauermann
IBM Linux Technology Center
