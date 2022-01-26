Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CAA49C2B0
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 05:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiAZEhN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jan 2022 23:37:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbiAZEhN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jan 2022 23:37:13 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q4Gdxg017398;
        Wed, 26 Jan 2022 04:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=LYqoHdWQXZGPFrhBmVZKxUrQMKp/AaJdoDHLAktpfj4=;
 b=RIb+2krzv6YCjfgFwsC0b6QnPIhrqpX979at9XhUH4pdyAzDagtuZuKcywfCaFKEfRTY
 n289rct36UcljTLeVgt57YDj+ihCEVxpX3FD9OVEtjje2BrV+ULM2UgzQ0JkzlWcLPax
 HXlA40nZ6lNfa1D3wobao+cJh2W4dNWKQZ0uDX4vkMwzserg2UDVNT+F3CO0folDZ3Cu
 OIl82yNy/sNOv/6Y2XeyxHehac0wlO13WktKHcurmMeZxyFLyAAmVipVGvGbJ7jrYWJS
 PHqh4+aBWOcOg8YGzhESWQd6PGXu8AT1Dsj8m2UWSEpvGO/C0SoeFhdFuOpJCI2BeRvn aQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dty4p08uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 04:37:08 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20Q4X82H029033;
        Wed, 26 Jan 2022 04:37:05 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3dr9j9hguc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 04:37:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20Q4b3m941877994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 04:37:03 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3D825204E;
        Wed, 26 Jan 2022 04:37:02 +0000 (GMT)
Received: from sig-9-65-77-22.ibm.com (unknown [9.65.77.22])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DA9AC52051;
        Wed, 26 Jan 2022 04:37:01 +0000 (GMT)
Message-ID: <71508a72b042da330d07a624cf499561c46195f0.camel@linux.ibm.com>
Subject: Re: [RESEND][PATCH] Documentation: added order requirement for
 ima_hash=
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        roberto.sassu@huawei.com, wangweiyang2@huawei.com,
        xiujianfeng@huawei.com, linux-integrity@vger.kernel.org
Date:   Tue, 25 Jan 2022 23:37:01 -0500
In-Reply-To: <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
References: <20220125090237.120357-1-guozihua@huawei.com>
         <36b6058f2cdf6bead917c06ecc6e8769bb88130c.camel@linux.ibm.com>
         <3933adf5-4e9d-6b22-2e46-55643c504f52@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iB0F-y1qqEFzVjYgQjVD1gV8Uk6pDzGm
X-Proofpoint-ORIG-GUID: iB0F-y1qqEFzVjYgQjVD1gV8Uk6pDzGm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_01,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260022
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-01-26 at 10:28 +0800, Guozihua (Scott) wrote:
> 
> On 2022/1/26 9:07, Mimi Zohar wrote:
> > On Tue, 2022-01-25 at 17:02 +0800, GUO Zihua wrote:
> >> From: Guo Zihua <guozihua@huawei.com>
> >>
> >> Commandline parameter ima_hash= and ima_template= has order requirement
> >> for them to work correctly together. Namely ima_hash= must be
> >> specified after ima_template=, otherwise ima_template= will be ignored.
> >>
> >> The reason is that when handling ima_hash=, ima template would be set to
> >> the default value if it has not been initialized already, and that value
> >> cannot be changed afterwards by ima_template=.
> >>
> >> This patch adds this limitation to the documentation.
> >>
> >> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> >> Signed-off-by: Guo Zihua <guozihua@huawei.com>
> > 
> > This issue should be limited to the original "ima" template format,
> > which only supports hash algorithms of 20 bytes or less.  The "ima_ng"
> > template has been the default since larger digests and templates were
> > upstreamed back in Linux 3.13[1]. Do you really still have kernels
> > built with the original "ima" template?
> > 
> > [1] Refer to commit 4286587dccd4 ("ima: add Kconfig default measurement
> > list template").
> 
> Hi Mimi,
> 
> The issue is that if ima_hash is specified before ima_template, 
> ima_template will not work. Built-in default only affects which template 
> will be loaded eventually.
> 
> For example, if the built-in default template is ima-ng and user would 
> like to change it to ima-sig with sha512 by specifying "ima_hash=sha512 
> ima_template=ima-sig" in command line, the result will be ima-ng with 
> sha512, not ima-sig with sha512.

Ok.  Once the template name is set, ima_template_setup() doesn't allow
it to be reset.  This was probably done to set the template name to the
first occurance of "ima_template=" on the boot command line.  This
concern could be addressed by defining a static local variable in
ima_template_setup().

So either documenting the ordering requirement, as you've done, or
allowing the template_name to be reset are fine.

thanks,

Mimi







