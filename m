Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B563D544F02
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jun 2022 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbiFIO3R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Jun 2022 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbiFIO2y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Jun 2022 10:28:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D51D0581;
        Thu,  9 Jun 2022 07:28:51 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 259DkBCQ007837;
        Thu, 9 Jun 2022 14:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=BMK2RcYGfDwfWKAQf1dsbtB2ffMcLJIkRzaY8eo1+0Y=;
 b=tQ4eAZPxCwgOGTTjHqXQB8Yqj/4yWjWxh4r/upUVch/2svZszgy51HfDIJQ/Wjyf9x2C
 kNX5PEQghTZDE3n+rYNzD8syHpGKgVyw/kXJby0uF/w1L3ZoSvg7f97YPOe0ucI0m+JW
 UR7nQNhDqwxU7TFZFIkwj2mW3iLX0Ekjwk9jM1dXUUYsyIQP4nCcxqt3w6NL4hI3ukQp
 up7E4uisSy203+gnkPetvg6ch9aYUamUZyHjv+QBUJK1z2jqcfBoTMuzOuWzTV+NWgrA
 oD02kSx3WXvb88+SEdtAO7VtPoM+M8FrO3wnLUeUnCZwrfGhD9w1i5s/vgjH10t2k307 mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkj1j8xv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 14:28:08 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 259DlpN2013121;
        Thu, 9 Jun 2022 14:28:08 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gkj1j8xu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 14:28:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 259E6Mvu005858;
        Thu, 9 Jun 2022 14:28:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3gfy19f2bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jun 2022 14:28:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 259ES1xG13762924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Jun 2022 14:28:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD30C4C044;
        Thu,  9 Jun 2022 14:28:01 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 969014C040;
        Thu,  9 Jun 2022 14:27:58 +0000 (GMT)
Received: from sig-9-65-64-6.ibm.com (unknown [9.65.64.6])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  9 Jun 2022 14:27:58 +0000 (GMT)
Message-ID: <686b3d50a03d189f965e90d47043f9a515eb4199.camel@linux.ibm.com>
Subject: Re: [PATCH v12 01/26] securityfs: rework dentry creation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <brauner@kernel.org>,
        James Morris <jmorris@namei.org>
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, John Johansen <john.johansen@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Micah Morton <mortonm@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Jarkko Sakkinen <jarkko@kernel.org>
Date:   Thu, 09 Jun 2022 10:27:58 -0400
In-Reply-To: <20220510204151.GA12935@mail.hallyn.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
         <20220420140633.753772-2-stefanb@linux.ibm.com>
         <20220509195414.GA30894@mail.hallyn.com>
         <20220510102525.hlt2rm3k3hg5r6gg@wittgenstein>
         <20220510141025.GA7290@mail.hallyn.com>
         <20220510155107.srxifzuqfstvet2f@wittgenstein>
         <20220510204151.GA12935@mail.hallyn.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FdkeeX_OpzDnD7xynR3IFonJRL0P0Ffm
X-Proofpoint-GUID: efRawx1twZkB0tKMkSiF2xy8adpEXW3S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-09_10,2022-06-09_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=491 clxscore=1011 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206090058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

On Tue, 2022-05-10 at 15:41 -0500, Serge E. Hallyn wrote:

<snip>

> Reviewed-by: Serge Hallyn <serge@hallyn.com>

b4 properly applies Serge's tag.  Any chance you could take this patch
and, probably, 2/26 via the security tree?

thanks,

Mimi



