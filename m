Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D124D85F4
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Mar 2022 14:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbiCNNeU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Mar 2022 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiCNNeS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Mar 2022 09:34:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863CD13DDC;
        Mon, 14 Mar 2022 06:33:08 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EDDLpK003427;
        Mon, 14 Mar 2022 13:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=2EdUEKO7C2wVnzcjRKMo0ZjnW2dMNP1TkXpUeyGHeUY=;
 b=b5OGe9mZZYvseIRi5ky5sjPz1pW/jNFP+gHhl3U5V7gyuz2aK4S6CDVZ2yXw3ohXOik/
 mEIky/A5sv5Egdu/m9LRZMcK4hEJjAIeAy3v56YMbZoEIQwxxRNOoli0Yuy59SP7/+Tr
 I8jgIh4cF4FcnTjNf8wks2PGmNUQ1tjMGRlJOsf3m07hWok6Q1TCoV1wVKVwFnAnThmP
 e5dXBcvUMZkrZjaboBRcvzeltZqGY07uYBM9eSOsvr3DtAyca8a400PREmjz2u83FXZS
 ks2rq1SP1Jm/6PItVbaGVI4DiYMaz5C6UNBJwBUKz+9K0CeaRfSbkWohUTXO4+ShYw+r BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6d7gus1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 13:33:02 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EDDvI6008286;
        Mon, 14 Mar 2022 13:33:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6d7gn81-175
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 13:33:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22ECbAFu000559;
        Mon, 14 Mar 2022 12:53:56 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3erjshm3tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 12:53:56 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22ECrsS144695854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 12:53:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F422611C2A6;
        Mon, 14 Mar 2022 12:53:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58AC411C207;
        Mon, 14 Mar 2022 12:53:51 +0000 (GMT)
Received: from sig-9-65-88-214.ibm.com (unknown [9.65.88.214])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Mar 2022 12:53:50 +0000 (GMT)
Message-ID: <3b6693541d6e9055d59163b3f070c1831a93ea36.camel@linux.ibm.com>
Subject: Re: [PATCH v11 0/4] integrity: support including firmware
 ".platform" keys at build time
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 14 Mar 2022 08:53:50 -0400
In-Reply-To: <286a9ec3aa052cc1ed61e7257af492325d8e7279.camel@kernel.org>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
         <286a9ec3aa052cc1ed61e7257af492325d8e7279.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cCQ7tIY87CxG-HITufCPkgbARKKr-vLV
X-Proofpoint-ORIG-GUID: eBuUrsiXZRmx8zM2hDxU40RvGx9hVewb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_08,2022-03-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203140085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2022-03-11 at 18:39 +0200, Jarkko Sakkinen wrote:
> On Thu, 2022-03-10 at 16:44 -0500, Nayna Jain wrote:
> > Some firmware support secure boot by embedding static keys to verify the
> > Linux kernel during boot. However, these firmware do not expose an
> > interface for the kernel to load firmware keys onto the ".platform"
> > keyring, preventing the kernel from verifying the kexec kernel image
> > signature.
> > 
> > This patchset exports load_certificate_list() and defines a new function
> > load_builtin_platform_cert() to load compiled in certificates onto the
> > ".platform" keyring.
> > 
> > Changelog:
> > v11:
> > * Added a new patch to conditionally build extract-cert if
> > PLATFORM_KEYRING is enabled.
> > 
> > v10:
> > * Fixed the externs warning for Patch 3.
> > 
> > v9:
> > * Rebased on Jarkko's repo - 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
> > 
> > v8:
> > * Includes Jarkko's feedback on patch description and removed Reported-by
> > for Patch 1.
> > 
> > v7:
> > * Incldues Jarkko's feedback on patch description for Patch 1 and 3.
> > 
> > v6:
> > * Includes Jarkko's feedback:
> >  * Split Patch 2 into two.
> >  * Update Patch description.
> > 
> > v5:
> > * Renamed load_builtin_platform_cert() to load_platform_certificate_list()
> > and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
> > suggested by Mimi Zohar.
> > 
> > v4:
> > * Split into two patches as per Mimi Zohar and Dimitri John Ledkov
> > recommendation.
> > 
> > v3:
> > * Included Jarkko's feedback
> >  ** updated patch description to include approach.
> >  ** removed extern for function declaration in the .h file.
> > * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
> > 
> > v2:
> > * Fixed the error reported by kernel test robot
> > * Updated patch description based on Jarkko's feedback.
> > 
> > Nayna Jain (4):
> >   certs: export load_certificate_list() to be used outside certs/
> >   integrity: make integrity_keyring_from_id() non-static
> >   certs: conditionally build extract-cert if platform keyring is enabled
> >   integrity: support including firmware ".platform" keys at build time
> > 
> >  certs/Makefile                                |  9 ++++++--
> >  certs/blacklist.c                             |  1 -
> >  certs/common.c                                |  2 +-
> >  certs/common.h                                |  9 --------
> >  certs/system_keyring.c                        |  1 -
> >  include/keys/system_keyring.h                 |  6 +++++
> >  security/integrity/Kconfig                    | 10 ++++++++
> >  security/integrity/Makefile                   | 15 +++++++++++-
> >  security/integrity/digsig.c                   |  2 +-
> >  security/integrity/integrity.h                |  9 ++++++++
> >  .../integrity/platform_certs/platform_cert.S  | 23 +++++++++++++++++++
> >  .../platform_certs/platform_keyring.c         | 23 +++++++++++++++++++
> >  12 files changed, 94 insertions(+), 16 deletions(-)
> >  delete mode 100644 certs/common.h
> >  create mode 100644 security/integrity/platform_certs/platform_cert.S
> > 
> > 
> > base-commit: fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9
> 
> I tuned tags. Nayna, Mimi is this how it should be:

Either v11 or v12 is fine by me, except Masahiro Yamada requested to
move extract_certs back to the scripts/ directory.  v12 moves
extract_certs back, as requested.  Also Nageswara Sastry tested both
v11 and v12 versions.

thanks,

Mimi

