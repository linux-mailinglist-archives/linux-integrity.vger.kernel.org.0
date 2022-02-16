Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B94B92A8
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Feb 2022 21:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbiBPU50 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Feb 2022 15:57:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiBPU5Z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Feb 2022 15:57:25 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B441FEBC8;
        Wed, 16 Feb 2022 12:57:12 -0800 (PST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21GJf2tQ009633;
        Wed, 16 Feb 2022 20:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=yMozd52o5Kp52G263XJ+wtV9GcMgmX0qqCfKBc0WSLY=;
 b=gJ1kglpzIH3jhEr8H+qcB9zFXDKI3L+corLcY7BPUf59WLrVFu+dNjJPwyAhY7qsBoBe
 DUuksLdAlGX4zmwllvl75wSEdCaOSKcVmYkNL4b6ZvZDWQQbHueoEeDxlfg0lnwKqorw
 cG7ywEmOlcBSC8lC/+FZCWMbMLVMkUSZ5ijyaTix4Z9F8q5ynmygnsd4/mf2e9iMk6qk
 Kl+UiU9omrKDFm15AJILtnY1DWK2lTsZql+Q/ZNM3K8ntQ3uThk+jCwM1ZYNUF+tPODt
 NZLKCaQck9w+gZnCvm+6xLJBBUGEtCz53Viz/DJTEur6tAu/XWENd+NBq3/GJ+dgIWlV QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e97fhhdq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:56:53 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21GKPTIZ026361;
        Wed, 16 Feb 2022 20:56:52 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e97fhhdph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:56:52 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21GKlsr1023656;
        Wed, 16 Feb 2022 20:56:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3e64haacp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Feb 2022 20:56:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21GKul9B43450704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Feb 2022 20:56:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 107F9AE05A;
        Wed, 16 Feb 2022 20:56:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC1A8AE04D;
        Wed, 16 Feb 2022 20:56:44 +0000 (GMT)
Received: from sig-9-65-80-253.ibm.com (unknown [9.65.80.253])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Feb 2022 20:56:44 +0000 (GMT)
Message-ID: <c4170de11d64d5927a8e2a2e0f7e8a6e69c6a558.camel@linux.ibm.com>
Subject: Re: [PATCH v10 06/27] ima: Move arch_policy_entry into ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>
Date:   Wed, 16 Feb 2022 15:56:44 -0500
In-Reply-To: <c350ccf1-f968-8b01-2f0d-015cabf39781@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-7-stefanb@linux.ibm.com>
         <bf435ffa5d176213acabb8c576c159d2cbd4d395.camel@linux.ibm.com>
         <c350ccf1-f968-8b01-2f0d-015cabf39781@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: djqkQfF5y4r0lmYcOxyjbSbWE0vOxArS
X-Proofpoint-ORIG-GUID: PpWKXGxwuqiiPmOzdrGJGZbp5Kjotx40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_09,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-02-16 at 15:48 -0500, Stefan Berger wrote:
> On 2/16/22 11:39, Mimi Zohar wrote:
> > On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote
> >
> > Let's update the patch description providing a bit more background
> > info:
> >
> > The archictecture specific policy rules, currently defined for EFI and
> > powerpc, require the kexec kernel image and kernel modules to be
> > validly signed and measured, based on the system's secure boot and/or
> > trusted boot mode and the IMA_ARCH_POLICY Kconfig option being enabled.
> >
> >> Move the arch_policy_entry pointer into ima_namespace.
> > Perhaps include something about namespaces being allowed or not allowed
> > to kexec a new kernel or load kernel modules.
> 
> Namespaces are not allowed to kexec but special-casing the init_ima_ns 
> in the code to handle namespaces differently makes it much harder to 
> read the code. I would avoid special-casing init_ima_ns as much as 
> possible and therefore I have moved the arch_policy_entry into the 
> ima_namespace.

Please include this in the patch description, but re-write the last
line in the 3rd person, like:

To avoid special-casing init_ima_ns, as much as possible, move the
arch_policy_entry into the ima_namespace.

thanks,

Mimi


