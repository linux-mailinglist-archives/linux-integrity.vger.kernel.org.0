Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21751604762
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiJSNhl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSNg6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 09:36:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BBF12D813;
        Wed, 19 Oct 2022 06:25:26 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JDFgGV002967;
        Wed, 19 Oct 2022 13:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=DVW03iTiTRTyayeqLUvLgu638TsI5iFPDEtu5YBUGdY=;
 b=LR2a5igEdy+qgsweIHBHmRr+SHmak/XXDMlFKTePwJIjo2knWnb4bvSowhVkzi28O+xr
 74kMGbDVXjlBomtcJsksgo+XnhOY2Po3JBLra0Hi7yN3QZoy6+uwG1uLiLxqi08l3WUU
 RZT8PpxmsiofZ4zNt5SJK2Fi2OaUo+RWoD0z5RBcCjpxJNw3//9XoNIaRMOYL7czwsvF
 qZBlgk2Rbzp3j0l9lrg4gjWaL7djHvL9/6asdRRtNfW12VvAbaO9tW8eJS3rttoaV0Qe
 baKTAcChWdOKP77Y6c0E9MQArG4FzD7l3NIumTtxSh5Gnap0Bb49Tn9LHxJZ/2IWS7oj oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kahyb0e48-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 13:24:09 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29JDGL51006539;
        Wed, 19 Oct 2022 13:24:09 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kahyb0e3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 13:24:08 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29JDNoe1021140;
        Wed, 19 Oct 2022 13:24:08 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3k7mg9ny5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 13:24:08 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29JDOAA461669648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 13:24:10 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E90C758061;
        Wed, 19 Oct 2022 13:24:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC12158057;
        Wed, 19 Oct 2022 13:24:05 +0000 (GMT)
Received: from sig-9-65-252-68.ibm.com (unknown [9.65.252.68])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 19 Oct 2022 13:24:05 +0000 (GMT)
Message-ID: <7b6f01c201ce82f58c19a1e22df9333f30eedda5.camel@linux.ibm.com>
Subject: Re: [PATCH 3/9] ima: Move xattr hooks into LSM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Borislav Petkov <bp@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        Takashi Iwai <tiwai@suse.de>, Petr Vorel <pvorel@suse.cz>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 19 Oct 2022 09:24:05 -0400
In-Reply-To: <20221018150751.3qsbehcnli4c4g4o@wittgenstein>
References: <20221013222702.never.990-kees@kernel.org>
         <20221013223654.659758-3-keescook@chromium.org>
         <20221018150751.3qsbehcnli4c4g4o@wittgenstein>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qAO7TduTXm7UKdzpxb-rqCPH3_RjdJHr
X-Proofpoint-ORIG-GUID: xUE2GvXWPHkkknVG_aXO0rT3CK50EAdq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_08,2022-10-19_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=659
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190070
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-10-18 at 17:07 +0200, Christian Brauner wrote:
> On Thu, Oct 13, 2022 at 03:36:48PM -0700, Kees Cook wrote:
> > Move the xattr IMA hooks into normal LSM layer. As with SELinux and
> > Smack, handle calling cap_inode_setxattr() internally.
> > 
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: James Morris <jmorris@namei.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Jonathan McDowell <noodles@fb.com>
> > Cc: Takashi Iwai <tiwai@suse.de>
> > Cc: Petr Vorel <pvorel@suse.cz>
> > Cc: linux-integrity@vger.kernel.org
> > Cc: linux-security-module@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> 
> I like that changes obviously but in general, does IMA depend on being
> called _after_ all other LSMs or is this just a historical artifact?

Calculating the EVM HMAC must be last, after the other security xattrs
have been updated.

-- 
thanks,

Mimi


