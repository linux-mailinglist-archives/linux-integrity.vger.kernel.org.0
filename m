Return-Path: <linux-integrity+bounces-7617-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93780C4CC85
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Nov 2025 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA89424606
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Nov 2025 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0369921C9E5;
	Tue, 11 Nov 2025 09:47:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B382212560;
	Tue, 11 Nov 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762854420; cv=none; b=YIVcU6yVa24WWB/HwAOSg2cOTs/xe2u2TlSu36FbQN215VSfnxp1mcNunLkpByEHazROZsrk8UDhnkuhYwaf+U5CrkgbQ5Mm8rGnQqjOvEGY286dfHxFPolrIY3yS9VgwgkhVX50kWaU148+5Dt/z+MFUZPrNyxWjXYpxdJYO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762854420; c=relaxed/simple;
	bh=YJImL9JwpwHFaQkz6RgNOBjxa1zQLIH0mZqIWcOdz4g=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e45AXFCd00+2px12JvibO3YVWSc/bZsOSF/4nA+ZgfYaDTMrCQOHxiBkzy5Qo7ktaa5876y7M8FsfRBjBMmD6LWu3c+EkbgY3WRogGDIKKdC8ERCyuwHx6WpT6mtOjn3Cq0m0FiHi45bp+gBvfT0uGhMkv+g1Fe3JAciJyfTiYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4d5M9566SrzpTcP;
	Tue, 11 Nov 2025 17:45:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 75C00140278;
	Tue, 11 Nov 2025 17:46:49 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCn3SH_BRNpqOAyAA--.27253S2;
	Tue, 11 Nov 2025 10:46:48 +0100 (CET)
Message-ID: <03dbbabc5c431c579f06ad04a02adc8ef141f745.camel@huaweicloud.com>
Subject: Re: [Patch V1] ima: avoid duplicate policy rules insertions
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Tahera Fahimi <taherafahimi@linux.microsoft.com>, Anirudh Venkataramanan
 <anirudhve@linux.microsoft.com>, zohar@linux.ibm.com,
 roberto.sassu@huawei.com,  dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com,  jmorris@namei.org,
 serge@hallyn.com, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 code@tyhicks.com
Date: Tue, 11 Nov 2025 10:46:36 +0100
In-Reply-To: <14c61ba5-437f-496d-8356-5712ddb37d47@linux.microsoft.com>
References: <20251106181404.3429710-1-taherafahimi@linux.microsoft.com>
	 <b36a6508-1b2a-4c87-b3b5-9af0b402dc0b@linux.microsoft.com>
	 <14c61ba5-437f-496d-8356-5712ddb37d47@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCn3SH_BRNpqOAyAA--.27253S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGFyrAw15CryrGF4rAw1kKrg_yoWkuF1kpr
	s5JFWUCry5Jrn5Jr1UWr1UXFyYyr1UJ3WDJr48XFyUJrnxJr12gr15Wryq9F1UJr48Jr1U
	XF1UXrsxZr15XFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBGkSnDADmwABsC

On Mon, 2025-11-10 at 11:06 -0800, Tahera Fahimi wrote:
> On 11/6/2025 12:32 PM, Anirudh Venkataramanan wrote:
> > On 11/6/2025 10:14 AM, Tahera Fahimi wrote:
> > > Prevent redundant IMA policy rules by checking for duplicates before =
insertion. This ensures that
> > > rules are not re-added when userspace is restarted (using systemd-sof=
t-reboot) without a full system
> > > reboot. ima_rule_exists() detects duplicates in both temporary and ac=
tive rule lists.
> >=20
> > I have run into this too. Thanks for proposing a patch!
> >=20
> > FWIW - I am fairly new to the IMA subsystem, so feedback below is mostl=
y structural, with some IMA specific comments.
> Hi Ahirudh, Thanks for your feedback.
> > >=20
> > > Signed-off-by: Tahera Fahimi <taherafahimi@linux.microsoft.com>
> > > ---
> > > =C2=A0 security/integrity/ima/ima_policy.c | 157 ++++++++++++++++++++=
+++++++-
> > > =C2=A0 1 file changed, 156 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity=
/ima/ima_policy.c
> > > index 164d62832f8ec..3dd902101dbda 100644
> > > --- a/security/integrity/ima/ima_policy.c
> > > +++ b/security/integrity/ima/ima_policy.c
> > > @@ -1953,6 +1953,153 @@ static int ima_parse_rule(char *rule, struct =
ima_rule_entry *entry)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result;
> > > =C2=A0 }
> > > =C2=A0 +static bool template_has_field(const char *field_id, const st=
ruct ima_template_desc *template2)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 int j;
> >=20
> > j is declared in the loop header below too, which is more correct becau=
se it keeps the scope of j to be within the loop. So I'd say get rid of the=
 above declaration.
> The declaration of j is at the beginning to adhere proper kernel style an=
d ancient compile support.=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0 for (int j =3D 0; j < template2->num_fields; j++)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(field_id, temp=
late2->fields[j]->field_id) =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn true;
> > I believe the preferred kernel style is to use if (!strcmp(...)).
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0 return false;
> > > +}
> > > +
> > > +static bool keyring_has_item(const char *item, const struct ima_rule=
_opt_list *keyrings)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 int j;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 for (j =3D 0; j < keyrings->count; j++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(item, keyrings=
->items[j]) =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn true;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 return false;
> > > +}
> > > +
> > > +static bool labels_has_item(const char *item, const struct ima_rule_=
opt_list *labels)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 int j;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 for (j =3D 0; j < labels->count; j++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(item, labels->=
items[j]) =3D=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn true;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 return false;
> > > +}
> > > +
> > > +static bool ima_rules_equal(const struct ima_rule_entry *rule1, cons=
t struct ima_rule_entry *rule2)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 int i;
> >=20
> > i is used further down in this function, and even in all those cases, t=
he scope of i can be limited to the loop body where it's used.
> >=20
> > If you didn't know this already - you can use cppcheck to identify and =
reduce the scope of variables.
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (rule1->flags !=3D rule2->flags)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (rule1->action !=3D rule2->action)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (((rule1->flags & IMA_FUNC) && rule1->func !=
=3D rule2->func) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & (IMA_MAS=
K | IMA_INMASK)) && rule1->mask !=3D rule2->mask) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_FSMA=
GIC) && rule1->fsmagic !=3D rule2->fsmagic) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_FSUU=
ID) && !uuid_equal(&rule1->fsuuid, &rule2->fsuuid)) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_UID)=
 && !uid_eq(rule1->uid, rule2->uid)) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_GID)=
 && !gid_eq(rule1->gid, rule2->gid)) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_FOWN=
ER) && !uid_eq(rule1->fowner, rule2->fowner)) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_FGRO=
UP) && !gid_eq(rule1->fgroup, rule2->fgroup)) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_FSNA=
ME) && (strcmp(rule1->fsname, rule2->fsname) !=3D 0)) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_PCR)=
 && rule1->pcr !=3D rule2->pcr) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_VALI=
DATE_ALGOS) &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule1->allowe=
d_algos !=3D rule2->allowed_algos) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_EUID=
) && !uid_eq(rule1->uid, rule2->uid)) ||
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((rule1->flags & IMA_EGID=
) && !gid_eq(rule1->gid, rule2->gid)))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >=20
> > So the goal is to prevent the exact same policy rule from being added, =
not to update an existing rule, correct? IOW, you could end up with two ver=
y similar rules, because the new rule has one thing that's different compar=
ed to the existing rule?
>=20
> The purpose of this patch is to prohibit two exact same rule.

Why would an administrator attempt to load the same rule twice?

How likely is the case where one would like to combine multiple signed
IMA policies with common rules?

Unless there is a realistic use case, it would be better to patch user
space first.

Thanks

Roberto

> We can have other approaches like merging the new rule to the previously =
existing rule, ignore
> new rule if a similar rule exists. However, this approaches would add mor=
e complexity to the code
> and are not the purpose of this patch.
>=20
> > I feel that a little bit of commentary around what makes two rules the =
same would be useful.
> >=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (!rule1->template && !rule2->template) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> > You're trying to do nothing and continue on. A goto statement would com=
municate intent better. There are other places below with the same noop str=
ucture.
> >=20
> > To be fair, I also don't completely understand what you're trying to ac=
hieve here, Regardless, this "do nothing inside a conditional" looks weird =
and I feel like there should be a way to structure your logic without resor=
ting to this.
> >=20
> > > +=C2=A0=C2=A0=C2=A0 } else if (!rule1->template || !rule2->template) =
{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0 } else if (rule1->template->num_fields !=3D rule2=
->template->num_fields) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0 } else if (rule1->template->num_fields !=3D 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < rule1->=
template->num_fields; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (!template_has_field(rule1->template->fields[i]->field_id,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ru=
le2->template))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 }
> >=20
> > if + return will achieve the same end goals as else if + return, with l=
esser clutter. I have seen some static analyzers flag this pattern, but I c=
an't remember which one at the moment.
> >=20
> > So something like this:
> >=20
> > if (!rule1->template && !rule2->template)
> > =C2=A0=C2=A0=C2=A0 goto some_target;
> >=20
> > if (!rule1->template || !rule2->template)
> > =C2=A0=C2=A0=C2=A0 return false;
> >=20
> > if (rule1->template->num_fields !=3D rule2->template->num_fields)
> > =C2=A0=C2=A0=C2=A0 return false;
> >=20
> > if (rule1->template->num_fields !=3D 0) {
> > =C2=A0=C2=A0=C2=A0 for (i =3D 0; i < rule1->template->num_fields; i++) =
{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!template_has_field(rule=
1->template->fields[i]->field_id,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule2->template))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return false;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > }> some_target:
> > ...
> > ...
> I don't think having two goto in the code will improve its readability.
>=20
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (rule1->flags & IMA_KEYRINGS) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!rule1->keyrings && !=
rule2->keyrings) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> >=20
> > Another if block no-op
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!rule1->keyrin=
gs || !rule2->keyrings) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (rule1->keyring=
s->count !=3D rule2->keyrings->count) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (rule1->keyring=
s->count !=3D 0) {
> >=20
> > if (rule1->keyrings->count)
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
or (i =3D 0; i < rule1->keyrings->count; i++) {
> >=20
> > for (int i,
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (!keyring_has_item(rule1->keyrings->items[i], r=
ule2->keyrings))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (rule1->flags & IMA_LABEL) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!rule1->label && !rul=
e2->label) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> >=20
> > Another if block no-op
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!rule1->label =
|| !rule2->label) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (rule1->label->=
count !=3D rule2->label->count) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (rule1->label->=
count !=3D 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
or (i =3D 0; i < rule1->label->count; i++) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (!labels_has_item(rule1->label->items[i], rule2=
->label))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < MAX_LSM_RULES; i++) {
> >=20
> > for (int i,
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!rule1->lsm[i].rule &=
& !rule2->lsm[i].rule)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!rule1->lsm[i].rule |=
| !rule2->lsm[i].rule)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn false;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(rule1->lsm[i].=
args_p, rule2->lsm[i].args_p) !=3D 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn false;
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 return true;
> > > +}
> > > +
> > > +/**
> > > + * ima_rule_exists - check if a rule already exists in the policy
> > > + *
> > > + * Checking both the active policy and the temporary rules list.
> > > + */
> > > +static bool ima_rule_exists(struct ima_rule_entry *new_rule)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0 struct ima_rule_entry *entry;
> > > +=C2=A0=C2=A0=C2=A0 struct list_head *ima_rules_tmp;
> > > +
> > > +=C2=A0=C2=A0=C2=A0 if (!list_empty(&ima_temp_rules)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_for_each_entry(entry=
, &ima_temp_rules, list) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (ima_rules_equal(entry, new_rule))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +
> > > +=C2=A0=C2=A0=C2=A0 rcu_read_lock();
> > > +=C2=A0=C2=A0=C2=A0 ima_rules_tmp =3D rcu_dereference(ima_rules);
> > > +=C2=A0=C2=A0=C2=A0 list_for_each_entry_rcu(entry, ima_rules_tmp, lis=
t) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ima_rules_equal(entry=
, new_rule)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
cu_read_unlock();
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn true;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 }
> > > +=C2=A0=C2=A0=C2=A0 rcu_read_unlock();
> > > +
> > > +=C2=A0=C2=A0=C2=A0 return false;
> > > +}
> > > +
> > > =C2=A0 /**
> > > =C2=A0=C2=A0 * ima_parse_add_rule - add a rule to ima_policy_rules
> > > =C2=A0=C2=A0 * @rule: ima measurement policy rule
> > > @@ -1993,7 +2140,15 @@ ssize_t ima_parse_add_rule(char *rule)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0 -=C2=A0=C2=A0=C2=A0 list_add_tail(&entry->list, &ima_temp_rule=
s);
> > > +=C2=A0=C2=A0=C2=A0 if (!ima_rule_exists(entry)) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_add_tail(&entry->lis=
t, &ima_temp_rules);
> > > +=C2=A0=C2=A0=C2=A0 } else {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D -EEXIST;
> > Is it necessary to set result? Or can you just pass -EEXIST to the audi=
t call below?
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ima_free_rule(entry);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 integrity_audit_msg(AUDIT=
_INTEGRITY_STATUS, NULL,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, op, "duplicate-polic=
y", result,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 audit_info);
> > > +=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return len;
> > > =C2=A0 }
> I


