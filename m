Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868F04C1947
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 18:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243116AbiBWRFD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 12:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbiBWRFD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 12:05:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D794B413;
        Wed, 23 Feb 2022 09:04:35 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NGc2SE019566;
        Wed, 23 Feb 2022 17:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=V5ouTWLw3zk6L0EVif2Rdg9rNy4H1yV7hnOvL3gnssM=;
 b=qKluLf1I42VBFBFvldWEObuDNHYijYkC8+mr9xAwczW1RReL0F4cDFtfgWskQ3d3yXJU
 rv+knf+XheW06Z/6W3m3IJr/QhwMCDDg7LvZ4S5qqnlJACtEKONMmhVMuaB2PpdkxNNk
 7NtgpUrstwuQJUm2tUUsDrimdMDApkrEy65mJftMVfNKIAVUrS7tBWv+BZmvSpd0hU68
 TUXEwxTuztvt72yiRzAwVxs+Zi4hbQv19E219DKOO5enHJ3zzUaBDzgF9bPtp+RpXc1h
 sf9LXE7xMjLndBgv0aVfdGp47amcefnVuYbLAExSIJJmqrQ2Xa+WavudcFrh6fo6kcqB VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edpjum5qt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:04:20 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NGqQ0x025906;
        Wed, 23 Feb 2022 17:04:19 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3edpjum5p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:04:19 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NGwa8P004970;
        Wed, 23 Feb 2022 17:04:16 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3ear69a27c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 17:04:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NGrX2N50201010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 16:53:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A2534203F;
        Wed, 23 Feb 2022 17:04:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3E3742041;
        Wed, 23 Feb 2022 17:04:10 +0000 (GMT)
Received: from sig-9-65-80-154.ibm.com (unknown [9.65.80.154])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 17:04:10 +0000 (GMT)
Message-ID: <8a4f9cb6cab5ba04eb61e346d0fca16efa4c6703.camel@linux.ibm.com>
Subject: Re: [PATCH v10 26/27] ima: Limit number of policy rules in
 non-init_ima_ns
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
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Wed, 23 Feb 2022 12:04:10 -0500
In-Reply-To: <479f09e7-0d39-0281-45ef-5cce4861d24d@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-27-stefanb@linux.ibm.com>
         <5e4a862917785972281bbcb483404da01b71e801.camel@linux.ibm.com>
         <479f09e7-0d39-0281-45ef-5cce4861d24d@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7GjEqBC8iEN-xACjWX1NgiL5exLKGVfp
X-Proofpoint-GUID: phrRRm-ldqaBJQBzSZpKnWQVULfAUjcv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-02-23 at 11:37 -0500, Stefan Berger wrote:
> On 2/23/22 10:38, Mimi Zohar wrote:
> > On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> >> Limit the number of policy rules one can set in non-init_ima_ns to a
> >> hardcoded 1024 rules. If the user attempts to exceed this limit by
> >> setting too many additional rules, emit an audit message with the cause
> >> 'too-many-rules' and simply ignore the newly added rules.
> > This paragraph describes 'what' you're doing, not 'why'.  Please prefix
> > this paragraph with a short, probably one sentence, reason for the
> > change.
> >> Switch the accounting for the memory allocated for IMA policy rules to
> >> GFP_KERNEL_ACCOUNT so that cgroups kernel memory accounting takes effect.
> > Does this change affect the existing IMA policy rules for init_ima_ns?
> 
> There's typically no cgroup for the int_ima_ns, so not effect on 
> init_ima_ns.
> 
> Here's the updated text:
> 
> Limit the number of policy rules one can set in non-init_ima_ns to a
> hardcoded 1024 rules to restrict the amount of memory used for IMA's
> policy.

The question is "why" there should be a difference between the
init_ima_ns and non-init_ima_ns cases.  Perhaps something like, "Only
host root with CAP_SYS_ADMIN may write init_ima_ns policy rules, but in
the non-init_ima_ns case root in the namespace with CAP_MAC_ADMIN
privileges may write IMA policy rules.  Limit the total number of IMA
policy rules per namespace."

>  Ignore the added rules if the user attempts to exceed this
> limit by setting too many additional rules.
> 
> Switch the accounting for the memory allocated for IMA policy rules to
> GFP_KERNEL_ACCOUNT so that cgroups kernel memory accounting takes effect.
> This switch has no effect on the init_ima_ns.

thanks,

Mimi

