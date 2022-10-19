Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A236049AA
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 16:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiJSOsL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiJSOrp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 10:47:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9023A1D0C2;
        Wed, 19 Oct 2022 07:34:25 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JETpOk017385;
        Wed, 19 Oct 2022 14:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=6da2b4IDvCg61vIg9kdLbJyz6Rfh2p/wgmZ66CmuD7Y=;
 b=V0TtE1tP/W7QfTsTDVvuxF94RYDnmSZEwLLyD4NCSIE1ZsIqEjGEHc2t1b1eznarSHo5
 e1I8HbTFQu8oZMhCP4OTuvQVXZ6C5l0wDB6iPSZUIdgZbYN5mD1d8p7PogsAR2Hc/3Bs
 qtYMF7dpK7EICb8foSTphai81RVN71LRWCHTMMOk0IvfEhWYx6mSwdcn3+F4Np052gYm
 iMlbVq6fD+yuGokpZXJC0I6ag1y2QH771Pb6BdmPL+hr14cYSLrEvSlGsZBy1i6vp4TV
 or6FCtUl3TFPT6SyeQ7LCsSYIqJAW/ckcVzKw7OQfuwxiDo4WhP+NH6+twZJUR/2gEA7 hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kak27g3jf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:34:13 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29JEVl7a024686;
        Wed, 19 Oct 2022 14:34:12 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kak27g3hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:34:12 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JEL2PA002120;
        Wed, 19 Oct 2022 14:34:11 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3k7mg9baav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 14:34:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com ([9.208.128.132])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JEYBME8979020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 14:34:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C5C058056;
        Wed, 19 Oct 2022 14:34:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 308CA5804C;
        Wed, 19 Oct 2022 14:34:09 +0000 (GMT)
Received: from sig-9-65-252-68.ibm.com (unknown [9.65.252.68])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 14:34:09 +0000 (GMT)
Message-ID: <dd90cbafa0ba59be135a878bc7abcf4d322d43a1.camel@linux.ibm.com>
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 19 Oct 2022 10:34:08 -0400
In-Reply-To: <20221013223654.659758-1-keescook@chromium.org>
References: <20221013222702.never.990-kees@kernel.org>
         <20221013223654.659758-1-keescook@chromium.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7Cfkio-1ECrbGUdxF8vg60Z9FQWqyZIt
X-Proofpoint-ORIG-GUID: BPRiHgyWQmDlaFZDDiehoTkV3-K1lm8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=570 mlxscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210190081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-10-13 at 15:36 -0700, Kees Cook wrote:
> Move "integrity" LSM to the end of the Kconfig list and prepare for
> having ima and evm LSM initialization called from the top-level
> "integrity" LSM.

The securityfs integrity directory and the "iint_cache" are shared
IMA/EVM resources.  Just because the "iint_cache" was on an LSM hook,
it should never have been treated as an LSM on its own.  IMA maintains
and verifies file data integrity, while EVM maintains and verifies file
metadata integrity.  IMA and EVM may both be configured and enabled, or
independently of each other.   However, only if either IMA or EVM are
configured and enabled, should the iint_cache be created.  There is
absolutely no need for an independent "integrity" LSM.
-- 
thanks,

Mimi

