Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6D5334B92
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 23:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhCJW2Z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 17:28:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35555 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231919AbhCJW2C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 17:28:02 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12AMPKBt166470;
        Wed, 10 Mar 2021 17:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=tgKrZU7i0iMMBLUU8hg/UFd8eVIHr1j57T93sj+SGVs=;
 b=CnDAsvqWNBQXYKQaMBLiFq+tiUERksythCoLFGcxt2OTuVDoNuk6XFrVXRwdHnhV2GII
 Htb4pnTtGVlon56/J9I54P3igySOCyNM4/c1oVSTaKl2bXalrOQdRz2OogelZa+LdLei
 g8BzYcD/VlCH8H6GAOtPGCSwzHkmQSZI64D/kl3KNlLKc6IveTlfX0eAIqwHWGXqcVvM
 i88WIAdPc5Lx2Rde1szIs3sgDXNOMb5de1xcD/7jP4lCsHczFs5ghhHD+PNqykbMK/xu
 tRESW9IkK+82582uQUPC1DCiEiyWhNkSsvxYhWWDHRD7ApLhYWQq9JX1Bu8uoqRUdcpi Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3774m8c313-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:26:35 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12AMPLa2166575;
        Wed, 10 Mar 2021 17:26:35 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3774m8c30u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 17:26:35 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12AMGdW2030361;
        Wed, 10 Mar 2021 22:26:34 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3768rcp05s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 22:26:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12AMQWja17236380
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 22:26:33 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CABA87806D;
        Wed, 10 Mar 2021 22:26:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2031C7805C;
        Wed, 10 Mar 2021 22:26:29 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.80.211.242])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 10 Mar 2021 22:26:28 +0000 (GMT)
Message-ID: <9aa3173ab46b0aa7edb8146ffd3df05c1f74207e.camel@linux.ibm.com>
Subject: Re: [PATCH v9 0/4] Introduce TEE based Trusted Keys support
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Markus Wamser <Markus.Wamser@mixed-mode.de>,
        Luke Hinds <lhinds@redhat.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org
Date:   Wed, 10 Mar 2021 14:26:27 -0800
In-Reply-To: <YEkkXbWrYBTcGXEd@kernel.org>
References: <20210301131127.793707-1-sumit.garg@linaro.org>
         <CAFA6WYO4HHhtymaUzmkuaCZybTAWBQ=4K9Dez1pe1kqo3AJhuA@mail.gmail.com>
         <YEEANW+khw3nJtcQ@kernel.org>
         <CAFA6WYOxsYin8wBB_yU=S-bnqM-g5TFnTU_KXxc3wSBfx_N_6A@mail.gmail.com>
         <YEkkXbWrYBTcGXEd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_12:2021-03-10,2021-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-03-10 at 21:56 +0200, Jarkko Sakkinen wrote:
[...]
> I also need to apply 
> 
> https://lore.kernel.org/linux-integrity/20210127190617.17564-1-James.Bottomley@HansenPartnership.com/
> 
> and I would like to do both while I'm at it.
> 
> James, there was one patch that needed fixing but I cannot find
> lore.kernel.org link. Can you point me to that so that we
> can proceed?

I think you mean this one observing a missing space in the commit
message:

https://lore.kernel.org/keyrings/1327393.1612972717@warthog.procyon.org.uk/

James


