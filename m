Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F0C4C076B
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 02:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbiBWBwT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Feb 2022 20:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236159AbiBWBwT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Feb 2022 20:52:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A32CDF36;
        Tue, 22 Feb 2022 17:51:52 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21N0ii3x027359;
        Wed, 23 Feb 2022 01:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=zUtRqjv+W42yN3awX3xuSRmJqo0xao+UHMPCG4wnEEA=;
 b=LXfPt2otVXdYiVP4eCllNMmlD4ZYC1hrrvIqUfGnsqLA6wwY7Sxa7LE8QumyKXgODP4Q
 Jmbqc8kf+9FZ8flHBM2tZDfZWinmoXTtcyxIC9u/HhhDXcqVfAo8TxiAVmyO4T/KPoPw
 2lVekoqJntWWbPj2ZD6OmdlvgK3c6voTeuSiwwFyyDDkhGqnwGrJAu+KAcU8iVbDmP5w
 9TzGLywY2ATzvaMbgZQHTg8yuxpjz7eyMVFvU/wzQu8NpfsieOxqSUXZJ7/39o7OREI+
 b35KynZqhjCcVuSeQkYCi9+cUia8/lcPUyFvsSKrRJLkcwSdAKMq5OrM9CW+1dgjbSnj tg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ed6qm54mk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 01:51:43 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21N1lbU4017541;
        Wed, 23 Feb 2022 01:51:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3ear696kkx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 01:51:41 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21N1pdFp54460802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 01:51:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57D28AE051;
        Wed, 23 Feb 2022 01:51:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75E9EAE045;
        Wed, 23 Feb 2022 01:51:38 +0000 (GMT)
Received: from sig-9-65-81-84.ibm.com (unknown [9.65.81.84])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 01:51:38 +0000 (GMT)
Message-ID: <22049fd84a98fd8896609a24bd300783bd9c7384.camel@linux.ibm.com>
Subject: Re: [EXTERNAL] [PATCH] EVM: fix the evm= __setup handler return
 value
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        linux-security-module@vger.kernel.org
Cc:     Igor Zhbanov <i.zhbanov@omprussia.ru>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Date:   Tue, 22 Feb 2022 20:51:37 -0500
In-Reply-To: <20220222214518.9316-1-rdunlap@infradead.org>
References: <20220222214518.9316-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kg1rRpHXfkdLRWh7K2-vbSBNMhdmJbet
X-Proofpoint-GUID: kg1rRpHXfkdLRWh7K2-vbSBNMhdmJbet
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_08,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230004
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-02-22 at 13:45 -0800, Randy Dunlap wrote:
> __setup() handlers should return 1 if the parameter is handled.
> Returning 0 causes the entire string to be added to init's
> environment strings (limited to 32 strings), unnecessarily polluting it.
> 
> Using the documented string "evm=fix" causes an Unknown parameter message:
>   Unknown kernel command line parameters
>   "BOOT_IMAGE=/boot/bzImage-517rc5 evm=fix", will be passed to user space.
> 
> and that string is added to init's environment string space:
>   Run /sbin/init as init process
>     with arguments:
>      /sbin/init
>     with environment:
>      HOME=/
>      TERM=linux
>      BOOT_IMAGE=/boot/bzImage-517rc5
>      evm=fix
> 
> With this change, using "evm=fix" acts as expected and an invalid
> option ("evm=evm") causes a warning to be printed:
>   evm: invalid "evm" mode
> but init's environment is not polluted with this string, as expected.
> 
> Fixes: 7102ebcd65c1 ("evm: permit only valid security.evm xattrs to be updated")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Igor Zhbanov <i.zhbanov@omprussia.ru>
> Link: lore.kernel.org/r/64644a2f-4a20-bab3-1e15-3b2cdd0defe3@omprussia.ru

Thanks,  Randy, Igor.

The patch is queued in #next-integrity-testing.

Mimi







